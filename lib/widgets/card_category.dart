import 'package:flutter/material.dart';

class CardCategory extends StatefulWidget {
  String title;
  String img;
  Color colorStart;
  Color colorEnd;
  Function onTap;
  Function onDelete;
  int id;

  CardCategory(
      {this.title,
        this.img,
        this.colorStart,
        this.colorEnd,
        this.onTap,
        this.onDelete,
        this.id});

  @override
  _CardCategoryState createState() => _CardCategoryState();
}

class _CardCategoryState extends State<CardCategory> {

  bool showDeleteBtn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      stops: [0.5, 1],
                      colors: [widget.colorStart, widget.colorEnd])),
              child: InkWell(
                onTap: widget.onTap,
                onLongPress: openDeleteChoice,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                          tag: (widget.img + widget.id.toString()),
                          child: Container(height: 75, child: Image.asset(widget.img))),
                      Text(
                        widget.title,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if(showDeleteBtn)
              Positioned(
                top: -15,
                right: -15,
                child: IconButton(
                  icon: Icon(Icons.delete,color: Colors.red,),
                  onPressed: () {
                    widget.onDelete();
                  },
                ),
              )
          ],
        ),
      ),
    );
  }

  void openDeleteChoice() {
    setState(() {
      showDeleteBtn = true;
    });
  }
}
