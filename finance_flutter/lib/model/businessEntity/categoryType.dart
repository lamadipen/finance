enum CategoryType {
  EXPENSES,
  REVENUE,
  COST_OF_GOODS_SOLD
}

extension CategoryTypeExtension on CategoryType {
  String get name {
    switch (this) {
      case CategoryType.EXPENSES:
        return 'expenses';
      case CategoryType.REVENUE:
        return 'revenue';
      case CategoryType.COST_OF_GOODS_SOLD:
        return 'cost of goods sold';
      default:
        return null;
    }
  }

  void talk() {
    print('meow');
  }
}