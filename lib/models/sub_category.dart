class SubCategory {
  String title;
  int id;
  int categoryId;

  SubCategory.name(this.id, this.categoryId, this.title);

  SubCategory({this.categoryId, this.title});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'title': title, 'categoryId': categoryId};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  SubCategory.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    categoryId = map['categoryId'];
  }
}
