import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/db_helper.dart';
import 'package:flutter_app/models/sub_category.dart';

class SubCategoriesProviders with ChangeNotifier {
  List<SubCategory> _subCategories = [];

  List<SubCategory> get subCategories {
    return [..._subCategories];
  }

  Future<void> fetchAndSetSubCategories(int categoryId) async {
    _subCategories = [];

    final dataList = await DBHelper.getData('subcategories');

    _subCategories = dataList
        .map((subCatagory) => SubCategory.fromMap(subCatagory))
        .toList();

    _subCategories.removeWhere((element) => element.categoryId != categoryId);

    notifyListeners();
  }

  Future<void> deleteOneSubCategory(int id) async {
    final db = await DBHelper.dataBaseTierList();
    await db
        .rawDelete('DELETE FROM subcategories WHERE id = ?', [id.toString()]);
    // TODO remove all children
    _subCategories.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> addSubCategory(String title, int categoryId) async {
    SubCategory subCategory = SubCategory(categoryId: categoryId, title: title);

    int index = await DBHelper.insert('subcategories', subCategory.toMap());
    subCategory.id = index;
    await _subCategories.add(subCategory);
    notifyListeners();
  }
}
