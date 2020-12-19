import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';

import 'card_classement.dart';

class ClassementViewer extends StatefulWidget {
  List<Item> items;

  ClassementViewer(this.items);

  @override
  _ClassementViewerState createState() => _ClassementViewerState();
}

class _ClassementViewerState extends State<ClassementViewer> {
  final _pageController = PageController(viewportFraction: 0.4);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        Item item = widget.items[index];
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 1.0;

            if (_pageController.position.haveDimensions) {
              value = _pageController.page - index;

              if (value >= 0) {
                double _lowerLimit = 0;
                double _upperLimit = pi / 1.5;

                value =
                    (_upperLimit - (value.abs() * (_upperLimit - _lowerLimit)))
                        .clamp(_lowerLimit, _upperLimit);

                value = _upperLimit - value;
                value *= -1;
              }
            } else {
              //Won't work properly in case initialPage in changed in PageController
              if (index == 0) {
                value = 0;
              } else if (index == 1) {
                value = -1;
              }
            }

            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(value),
              alignment: Alignment.center,
              child: CardClassement(item),
            );
          },
          child: CardClassement(item),
        );
      },
    );
  }
}
