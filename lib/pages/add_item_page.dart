import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/sub_category.dart';
import 'package:flutter_app/providers/item_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatefulWidget {
  static const routeName = '/additem';

  int subCategoryId;
  SubCategory subCategory;

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff183aa9);
  File _image;
  final picker = ImagePicker();
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerComment = TextEditingController();
  TextEditingController controllerRating = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter ${widget.subCategory.title}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: getImage,
              child: Container(
                width: 150,
                height: 150,
                color: Colors.grey,
                child: _image == null
                    ? Center(child: Text('No image selected.'))
                    : Image.file(
                        _image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            TextField(
              controller: controllerTitle,
              decoration:
                  InputDecoration(hintText: "Nom ${widget.subCategory.title}"),
            ),
            TextField(
              controller: controllerComment,
              decoration: InputDecoration(hintText: "Description"),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllerRating,
              decoration: InputDecoration(hintText: "Note /10"),
            ),
            RaisedButton(
              color: currentColor,
              onPressed: choiceColor,
              child: Text(
                'Couleur',
                style: TextStyle(color: Colors.white),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await Provider.of<ItemProvider>(context, listen: false).addItem(
                    _image,
                    currentColor,
                    controllerTitle.text,
                    controllerComment.text,
                    double.parse(controllerRating.text),
                    widget.subCategoryId);
                Navigator.pop(context);
              },
              child: Text('Ajouter'),
            )
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  choiceColor() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          /*child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),*/
          /*child: MaterialPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
          ),*/
          child: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Got it'),
            onPressed: () {
              setState(() => currentColor = pickerColor);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }
}
