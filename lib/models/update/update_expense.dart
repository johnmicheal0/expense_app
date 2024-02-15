class UpdateExpense {
  int id;
  String product;
  double price;
  String? time;
  String? location;
  UpdateExpense(
      {required this.id,
      required this.product,
      required this.price,
      this.time,
      this.location});
}
