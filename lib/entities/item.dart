class Item {
  double price;
  double discount;
  String title;

  Item({this.title, this.price, this.discount});

  bool get hasDiscount => discount != 0;
}
