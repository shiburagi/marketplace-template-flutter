class Item {
  double price;
  double discount;
  String title;
  String image;

  String description;

  Item({this.title, this.price, this.discount, this.image,  this.description});

  bool get hasDiscount => discount != 0;
  double get priceAfterDiscount => price * (1.0 - discount / 100);
}
