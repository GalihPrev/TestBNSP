import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:flutter_sertifikasi/DBHelper/DBHelper.dart';
import 'package:flutter_sertifikasi/entryfom.dart';
import 'package:flutter_sertifikasi/models/item.dart';
import 'package:intl/intl.dart';

import 'ItemDetails.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sertifikasi/models/item.dart';
import 'package:flutter_sertifikasi/ItemDetails.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item>? itemList;
  double total = 0.0;

  @override
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = <Item>[];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: const Text("Tambah Item"),
                      onPressed: () async {
                        var item = await navigateToEntryForm(context, null);
                        if (item != null) {
                          int result = await dbHelper.insert(item);
                          if (result > 0) {
                            updateListView();
                          }
                        }
                      },
                    ),
                  ),
                  Text(
                    'Total Harga: ${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(total)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Item?> navigateToEntryForm(BuildContext context, Item? item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.labelLarge;
    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        total += itemList![index].price!;
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemList![index].name,
                  style: textStyle,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currencyFormat.format(itemList![index].price)),
                  ],
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(padding: EdgeInsets.only(left: 11)),
                GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () async {
                    int result = await dbHelper.delete(itemList![index].id);
                    if (result > 0) {
                      updateListView();
                    }
                  },
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  child: const Icon(Icons.edit),
                  onTap: () async {
                    var item =
                        await navigateToEntryForm(context, itemList![index]);
                    if (item != null) {
                      int result = await dbHelper.update(item);
                      if (result > 0) {
                        updateListView();
                      }
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetails(itemList![index]),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          count = itemList.length;
          total = itemList.fold(0, (sum, item) => sum + (item.price ?? 0));
        });
      });
    });
  }
}
