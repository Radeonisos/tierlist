import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/db_helper.dart';
import 'package:flutter_app/models/item.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> _items = [];

  List<Color> colors = [
    Colors.red,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.deepOrange
  ];

  List<Item> get items {
    return [..._items];
  }

  Item get lastItemAdd {
    return _items.last;
  }

  Future<void> fetchAndSetItems(int subCategoryId) async {
    _items = [];

    final dataList = await DBHelper.getData('item');
    _items = dataList.map((item) => Item.fromMap(item)).toList();

    _items.removeWhere((element) => element.subCategoryId != subCategoryId);
    _items.sort((a, b) => a.rating.compareTo(b.rating));
    _items = _items.reversed.toList();
    notifyListeners();
  }

  Future<void> addItem(File img, Color color, String title, String comment,
      double rating, int subCategoryId) async {
    Item item = Item(
        subCategoryId: subCategoryId,
        rating: rating,
        title: title,
        comments: comment,
        img: img.readAsBytesSync(),
        dateCreated: DateTime.now(),
        colorB: color);

    int index = await DBHelper.insert('item', item.toMap());
    item.id = index;
    await _items.add(item);

    notifyListeners();
  }
}
