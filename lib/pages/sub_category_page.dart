import 'package:flutter/material.dart';
import 'package:flutter_app/models/category.dart';
import 'package:flutter_app/models/sub_category.dart';
import 'package:flutter_app/providers/sub_categories_provider.dart';
import 'package:provider/provider.dart';

import 'classement_page.dart';

class SubCategoryPage extends StatefulWidget {
  static const routeName = '/subcategory';

  Category category;

  SubCategoryPage(this.category);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
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
                  return Dismissible(
                    background: stackBehindDismiss(),
                    key: ObjectKey(subCat.id),
                    child: Card(
                      child: InkWell(
                        onTap: () => goToClassement(subCat),
                        child: ListTile(
                          title: Text(subCat.title),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      Provider.of<SubCategoriesProviders>(context,
                              listen: false)
                          .deleteOneSubCategory(subCat.id);
                    },
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
        onPressed: openAddSubCategory,
      ),
    );
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  openAddSubCategory() {
    showDialog(
        context: context,
        builder: (ctx) {
          String name = '';
          return StatefulBuilder(// You need this, notice the parameters below:
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: new Text("Ajouter une sous catégorie"),
              content: new TextField(
                textCapitalization: TextCapitalization.words,
                onChanged: (value) {
                  setState(() => name = value);
                },
                onEditingComplete: () => addSubCategory(name, ctx),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Annuler',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'Ajouter',
                    style: TextStyle(fontSize: 17),
                  ),
                  onPressed: name.isNotEmpty
                      ? () {
                          addSubCategory(name, ctx);
                        }
                      : null,
                ),
              ],
            );
          });
        });
  }

  void addSubCategory(String name, BuildContext ctx) {
    if (name.isNotEmpty) {
      Provider.of<SubCategoriesProviders>(context, listen: false)
          .addSubCategory(name, widget.category.id);
      Navigator.of(ctx).pop();
    }
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
