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

  String nameOfCategory = '';
  int indexChoiceImg = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF4d4d4d),
      title: Text(
        'Ajouter une catégorie',
        style: TextStyle(color: Colors.white),
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          padding: const EdgeInsets.all(3.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 260,
                child: GridView.count(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  crossAxisCount: 4,
                  children: List.generate(
                    iconCategories.length,
                    (index) => Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: indexChoiceImg == index
                            ? Colors.blue
                            : Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      child: InkWell(
                        child: Image.asset(iconCategories[index]),
                        onTap: () {
                          setState(() {
                            indexChoiceImg = index;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: TextField(
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    setState(() {
                      nameOfCategory = value;
                    });
                  },
                  onEditingComplete: addCategory,
                  decoration: InputDecoration(hintText: 'Nom catégorie'),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            'Annuler',
            style: TextStyle(color: Colors.red, fontSize: 17),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
            'Valider',
            style: TextStyle(fontSize: 17),
          ),
          onPressed: nameOfCategory.isEmpty ? null : addCategory,
        )
      ],
    );
  }

  void addCategory() {
    if (nameOfCategory.isNotEmpty) {
      widget.onPressedAdd(nameOfCategory, iconCategories[indexChoiceImg]);
      Navigator.of(context).pop();
    }
  }
}
