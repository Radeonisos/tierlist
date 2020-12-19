import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/sub_category.dart';
import 'package:flutter_app/providers/sub_catgories_provider.dart';
import 'package:provider/provider.dart';

import 'classement_page.dart';

class CategoryPage extends StatefulWidget {
  static const routeName = '/subcategory';

  Category category;

  CategoryPage(this.category);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String heroImgString = '';
  @override
  void initState() {
    super.initState();
    Provider.of<SubCategoriesProviders>(context, listen: false)
        .fetchAndSetSubCategories(widget.category.id);

    setState(() {
      heroImgString = widget.category.imgUrl + widget.category.id.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [
              0.5,
              1
            ],
                colors: [
              widget.category.colorStart,
              widget.category.colorEnd
            ])),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
            Center(
              child: Hero(
                  tag: heroImgString,
                  child: Container(
                      height: 100, child: Image.asset(widget.category.imgUrl))),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
                child: Consumer<SubCategoriesProviders>(
              builder: (ctx, subCategoriesData, child) => ListView.builder(
                itemCount: subCategoriesData.subCategories.length,
                itemBuilder: (context, index) {
                  SubCategory subCat = subCategoriesData.subCategories[index];
                  return Card(
                    child: InkWell(
                      onTap: () => goToClassement(subCat),
                      child: ListTile(
                        title: Text(subCat.title),
                      ),
                    ),
                  );
                },
              ),
            ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: addSubCategory,
      ),
    );
  }

  addSubCategory() {
    showDialog(
        context: context,
        builder: (ctx) {
          String name = '';
          return AlertDialog(
            title: new Text("Ajouter une sous catégorie"),
            content: new TextField(
              onChanged: (value) {
                name = value;
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ajouter'),
                onPressed: () async {
                  await Provider.of<SubCategoriesProviders>(context,
                          listen: false)
                      .addSubCategory(name, widget.category.id);
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text('Non'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          );
        });
  }

  goToClassement(SubCategory subCategory) {
    Navigator.pushNamed(
      context,
      ClassementPage.routeName,
      arguments: <String, Object>{
        'subCategory': subCategory,
        'imgCategory': widget.category.imgUrl,
      },
    );
  }
}
