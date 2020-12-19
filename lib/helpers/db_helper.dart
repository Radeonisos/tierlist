import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> dataBaseTierList() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'tierlist.db'),
        onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE categories(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, imgUrl TEXT, colorStart TEXT, colorEnd TEXT)");

      await db.execute(
          "CREATE TABLE subcategories(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, categoryId INTEGER)");

      return db.execute(
          "CREATE TABLE item(id INTEGER PRIMARY KEY AUTOINCREMENT, subCategoryId INTEGER, title TEXT, img TEXT, rating REAL, colorB TEXT, dateCreated TEXT, comments TEXT)");
    }, version: 1);
  }

  static Future<int> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.dataBaseTierList();
    return db.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.dataBaseTierList();
    return db.query(table);
  }

  static initDbWithValue() async {
    await DBHelper.insert(
        'categories',
        Category('Alcool', 'assets/images/alcool.png', Colors.blue,
                Colors.white70)
            .toMap());

    await DBHelper.insert(
        'categories',
        Category('Nourriture', 'assets/images/food.png', Colors.green,
                Colors.greenAccent)
            .toMap());

    await DBHelper.insert(
        'categories',
        Category('Lieux', 'assets/images/lieux.png', Colors.deepOrange,
                Colors.yellow)
            .toMap());

    await DBHelper.insert(
        'categories',
        Category('Oeuvre', 'assets/images/oeuvre.png', Colors.deepOrange,
                Colors.yellow)
            .toMap());
  }
}
