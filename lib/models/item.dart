import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/transform_var.dart';

class Item {
  int id, subCategoryId;

  double rating;

  String title, comments;

  DateTime dateCreated;

  Color colorB;
  Uint8List img;

  Item.name(this.id, this.subCategoryId, this.rating, this.title, this.comments,
      this.img, this.dateCreated, this.colorB);

  Item(
      {this.subCategoryId,
      this.rating,
      this.title,
      this.comments,
      this.img,
      this.dateCreated,
      this.colorB});

  Map<String, dynamic> toMap() {
    List<int> imageBytes = img.toList();

    var map = <String, dynamic>{
      'title': title,
      'comments': comments,
      'rating': rating,
      'subCategoryId': subCategoryId,
      'img': base64Encode(imageBytes),
      'colorB': colorB.toString(),
      'dateCreated': dateCreated.toString()
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    Uint8List _bytesImage = Base64Decoder().convert(map['img']);

    id = map['id'];
    title = map['title'];
    comments = map['comments'];
    rating = map['rating'];
    subCategoryId = map['subCategoryId'];
    img = _bytesImage;
    colorB = TransformVar.stringToColor(map['colorB']);
    dateCreated = DateTime.parse(map['dateCreated']);
  }
}
