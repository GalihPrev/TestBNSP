import 'package:flutter/material.dart';
import 'package:flutter_sertifikasi/daftarbarang.dart';

import 'HomePage.dart';
import 'daftarbarang.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambahkan Item',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home:const HomePage(),
    );
  }
}
