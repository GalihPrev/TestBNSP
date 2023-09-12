import 'package:flutter/src/widgets/icon_data.dart';

class Item {
  // String _name = '';
  // int _price = 0;
  // int _id = 0;

  // cara  2
  String? _name;
  int? _price;
  int? _id;
  String? _kode;

  int get id => _id!;

  String get name => _name!;
  set name(String value) => this._name = value;

  get price => _price!;
  set price(value) => _price = value;

  String get kode => _kode!;
  set kode(String value) => _kode = value;

// konstruktor versi 1
  Item(this._name, this._price, IconData ad_units, this._kode);

// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _price = map['price'];
    _kode = map['kode'];
  }
// konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['price'] = price;
    map['kode'] = kode;

    return map;
  }
}
