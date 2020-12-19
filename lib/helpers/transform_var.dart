import 'package:flutter/material.dart';

class TransformVar {
  static Color stringToColor(String col) {
    String valueString = col.split('(0x')[1].split(')')[0]; // kind of hacky..
    int value = int.parse(valueString, radix: 16);
    return new Color(value);
  }
}
