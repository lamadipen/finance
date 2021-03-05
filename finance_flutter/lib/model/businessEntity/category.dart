class Category {
  int id;
  String name;
  String categoryType;

  Category({this.id, this.name, this.categoryType});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        categoryType: json['categoryType']);
  }

  @override
  String toString() {
    return 'Category{id: $id, name: $name, categoryType: $categoryType}';
  }
}
