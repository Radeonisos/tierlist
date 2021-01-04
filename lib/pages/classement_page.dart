import 'package:flutter/material.dart';
import 'package:flutter_app/models/sub_category.dart';
import 'package:flutter_app/providers/item_provider.dart';
import 'package:flutter_app/widgets/card_classement.dart';
import 'package:flutter_app/widgets/classement_viewer.dart';
import 'package:provider/provider.dart';

import 'add_item_page.dart';

class ClassementPage extends StatefulWidget {
  static const routeName = '/classement';

  SubCategory subCategory;
  String imgCategory;

  ClassementPage(this.subCategory, this.imgCategory);

  @override
  _ClassementPageState createState() => _ClassementPageState();
}

class _ClassementPageState extends State<ClassementPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).fetchAndSetItems(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Hero(
                  tag: widget.imgCategory +
                      widget.subCategory.categoryId.toString(),
                  child: Image.asset(
                    widget.imgCategory,
                    fit: BoxFit.cover,
                    height: 40,
                  )),
              Text(widget.subCategory.title)
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // go to add item page
                  Navigator.pushNamed(
                    context,
                    AddItemPage.routeName,
                    arguments: widget.subCategory,
                  );
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    child: Consumer<ItemProvider>(
                        builder: (ctx, itemsData, child) =>
                            ClassementViewer(itemsData.items)),
                  ),
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset.center,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.0),
                            Colors.white.withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Consumer<ItemProvider>(
                  builder: (ctx, itemsData, child) => itemsData.items.length > 0
                      ? CardClassement(itemsData.lastItemAdd)
                      : Center()),
            )
          ],
        ));
  }
}
