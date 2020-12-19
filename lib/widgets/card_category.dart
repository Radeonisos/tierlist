import 'package:flutter/material.dart';

class CardCategory extends StatelessWidget {
  String title;
  String img;
  Color colorStart;
  Color colorEnd;
  Function onTap;
  int id;

  CardCategory(
      {this.title,
      this.img,
      this.colorStart,
      this.colorEnd,
      this.onTap,
      this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  stops: [0.5, 1],
                  colors: [colorStart, colorEnd])),
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: (img + id.toString()),
                      child: Container(height: 75, child: Image.asset(img))),
                  Text(
                    title,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
