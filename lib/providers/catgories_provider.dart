import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/db_helper.dart';
import 'package:flutter_app/models/category.dart';

class CategoriesProviders with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    _categories = [];
    final dataList = await DBHelper.getData('categories');

    _categories =
        dataList.map((catagory) => Category.fromMap(catagory)).toList();

    notifyListeners();
  }

  Future<void> deleteOneCategory(int id) async {

  }

  Future<void> addCategory(String name, String img) async {
    List colors = [Colors.red, Colors.green, Colors.orange, Colors.blue, Colors.amber];
    Random random = new Random();
    Category category = Category(name, img, colors[random.nextInt(colors.length)],
        Colors.white70);

    category.id  = await DBHelper.insert(
        'categories',
        category
            .toMap());
    await _categories.add(category);
    notifyListeners();
  }

  initDbWithValue() async {
    int id = await DBHelper.insert(
        'categories',
        Category('Alcool', 'assets/images/alcool.png', Colors.blue,
                Colors.white70)
            .toMap());

    await _categories.add(
      Category.name('Alcool', 'assets/images/alcool.png', Colors.blue,
          Colors.white70, id),
    );
    int id1 = await DBHelper.insert(
        'categories',
        Category('Nourriture', 'assets/images/food.png', Colors.green,
                Colors.greenAccent)
            .toMap());
    await _categories.add(
      Category.name('Nourriture', 'assets/images/food.png', Colors.green,
          Colors.greenAccent, id1),
    );
    int id2 = await DBHelper.insert(
        'categories',
        Category('Lieux', 'assets/images/lieux.png', Colors.deepOrange,
                Colors.yellow)
            .toMap());
    await _categories.add(Category.name('Lieux', 'assets/images/lieux.png',
        Colors.deepOrange, Colors.yellow, id2));

    int id3 = await DBHelper.insert(
        'categories',
        Category('Oeuvre', 'assets/images/oeuvre.png', Colors.deepOrange,
                Colors.yellow)
            .toMap());

    await _categories.add(Category.name('Oeuvre', 'assets/images/oeuvre.png',
        Colors.deepOrange, Colors.yellow, id3));

    notifyListeners();
  }
}
