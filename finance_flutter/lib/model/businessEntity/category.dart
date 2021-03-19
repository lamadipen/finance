enum Category {
  EXPENSES,
  REVENUE,
  COST_OF_GOODS_SOLD
}

extension CategoryExtension on Category {
  String get name {
    switch (this) {
      case Category.EXPENSES:
        return 'expenses';
      case Category.REVENUE:
        return 'revenue';
      case Category.COST_OF_GOODS_SOLD:
        return 'cost of goods sold';
      default:
        return null;
    }
  }
}