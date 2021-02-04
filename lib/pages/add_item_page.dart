import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/sub_category.dart';
import 'package:flutter_app/providers/item_provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddItemPage extends StatefulWidget {
  static const routeName = '/additem';

  SubCategory subCategory;

  AddItemPage(this.subCategory);

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

  final _formKey = GlobalKey<FormState>();
  bool imgError = false;

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter ${widget.subCategory.title}'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 220,
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            color: Colors.grey,
                            child: _image == null
                                ? Center(
                                    child: Text(
                                    'Veuillez choisir une image',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: imgError
                                            ? Colors.red
                                            : Colors.black),
                                  ))
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: RaisedButton(
                                  child: Text('Photo'),
                                  onPressed: () {
                                    getImage(ImageSource.camera);
                                  },
                                ),
                              ),
                              Expanded(
                                child: RaisedButton(
                                  onPressed: () {
                                    getImage(ImageSource.gallery);
                                  },
                                  child: Text('Galerie'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: controllerTitle,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        hintText: "Nom ${widget.subCategory.title}"),
                    onEditingComplete: () => node.nextFocus(),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nom invalide';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controllerComment,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: "Description"),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controllerRating,
                    decoration: InputDecoration(hintText: "Note /10"),
                    onEditingComplete: addItem,
                    validator: (value) {
                      if (value.isEmpty || value.contains(',')) {
                        return 'Note invalide. Veuillez écrire sous le format 8.5';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
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
                    onPressed: addItem,
                    child: Text('Ajouter'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addItem() async {
    setState(() {
      _image == null ? imgError = true : imgError = false;
    });
    if (_formKey.currentState.validate() && _image != null) {
      await Provider.of<ItemProvider>(context, listen: false).addItem(
          _image,
          currentColor,
          controllerTitle.text,
          controllerComment.text,
          double.parse(controllerRating.text),
          widget.subCategory.id);
      Navigator.pop(context);
    }
  }

  Future getImage(ImageSource imageSource) async {
    final pickedFile =
        await picker.getImage(source: imageSource, imageQuality: 10);

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
              FocusScope.of(context).unfocus();
            },
          ),
        ],
      ),
    );
  }
}
