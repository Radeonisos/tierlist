import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/transform_var.dart';

class Category {
  String title;
  String imgUrl;
  Color colorStart;
  Color colorEnd;
  int id;

  Category.name(
      this.title, this.imgUrl, this.colorStart, this.colorEnd, this.id);

  Category(this.title, this.imgUrl, this.colorStart, this.colorEnd);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'imgUrl': imgUrl,
      'colorStart': colorStart.toString(),
      'colorEnd': colorEnd.toString()
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    imgUrl = map['imgUrl'];
    colorStart = TransformVar.stringToColor(map['colorStart']);
    colorEnd = TransformVar.stringToColor(map['colorEnd']);
  }
}
