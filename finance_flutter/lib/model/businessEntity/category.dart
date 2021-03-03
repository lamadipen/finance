class Category{
    int id;
    String name;
    String categoryType;

    Category(this.id, this.name, this.categoryType);

    @override
  String toString() {
    return 'Category{id: $id, name: $name, categoryType: $categoryType}';
  }
}