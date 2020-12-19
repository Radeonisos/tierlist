import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/db_helper.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/providers/catgories_provider.dart';
import 'package:flutter_app/widgets/card_category.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'category_page.dart';

class Home extends StatefulWidget {
  static const routeName = '/category';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoriesProviders>(context, listen: false)
        .fetchAndSetCategories()
        .then((value) => {ifFirstTime()});
  }

  ifFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = (prefs.getBool('firstTime') ?? true);
    if (firstTime) {
      await DBHelper.initDbWithValue();
      await prefs.setBool('firstTime', false);
      Provider.of<CategoriesProviders>(context, listen: false)
          .fetchAndSetCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 0,
        title: Text('Mes Catégories'),
        backgroundColor: Colors.blue.withOpacity(0.9),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Consumer<CategoriesProviders>(
        builder: (ctx, categoriesData, child) => GridView.count(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 2,
          children: List.generate(categoriesData.categories.length, (index) {
            Category category = categoriesData.categories[index];
            return CardCategory(
              title: category.title,
              img: category.imgUrl,
              colorStart: category.colorStart,
              colorEnd: category.colorEnd,
              id: category.id,
              onTap: () => goToOneCategory(category),
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Provider.of<CategoriesProviders>(context, listen: false)
              .addCategory();
        },
      ),
    );
  }

  void goToOneCategory(Category category) {
    Navigator.pushNamed(
      context,
      CategoryPage.routeName,
      arguments: category,
    );
  }
}
