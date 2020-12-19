import 'package:flutter/material.dart';
import 'package:flutter_app/models/item.dart';

class CardClassement extends StatelessWidget {
  Item item;

  CardClassement(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              color: item.colorB,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        child: Image.memory(
                          item.img,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${item.rating}/10',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 25,
                            shadows: [
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title.toUpperCase(),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: Container(
                        child: Text(
                          item.comments,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
