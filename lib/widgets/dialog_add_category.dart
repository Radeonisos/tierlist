import 'package:flutter/material.dart';

class DialogAddCategory extends StatefulWidget {

  Function(String name, String img) onPressedAdd;

  DialogAddCategory(this.onPressedAdd);

  @override
  _DialogAddCategoryState createState() => _DialogAddCategoryState();
}

class _DialogAddCategoryState extends State<DialogAddCategory> {

  // todo : refacto this var
  List<String> iconCategories = [
    'assets/images/alcool.png',
    'assets/images/food.png',
    'assets/images/informatique.png',
    'assets/images/lieux.png',
    'assets/images/oeuvre.png',
    'assets/images/alcool.png',
    'assets/images/food.png',
    'assets/images/informatique.png',
    'assets/images/lieux.png',
    'assets/images/oeuvre.png',
    'assets/images/alcool.png',
    'assets/images/food.png',
    'assets/images/informatique.png',
    'assets/images/lieux.png',
    'assets/images/oeuvre.png',
  ];

  String nameOfCategory;
  int indexChoiceImg=0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // todo : change grey for more white
      backgroundColor: Colors.grey,
      title: Text('Ajouter une catégorie', style: TextStyle(color: Colors.white),),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height/2.5,
                child: GridView.count(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  crossAxisCount: 4,
                  children: List.generate(iconCategories.length,
                        (index) => Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: indexChoiceImg == index? Colors.blue: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                          ),
                          child: InkWell(child: Image.asset(iconCategories[index]),
                          onTap: (){
                            setState(() {
                              indexChoiceImg = index;
                            });
                          },),),),),
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      nameOfCategory = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Nom catégorie'
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: Text('Annuler', style: TextStyle(color: Colors.red),),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text('Valider', style: TextStyle(color: Colors.blue),),
                    onPressed: (){
                      widget.onPressedAdd(nameOfCategory,iconCategories[indexChoiceImg]);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}
