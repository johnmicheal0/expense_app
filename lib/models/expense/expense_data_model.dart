class ExpenseDataModel {
  int? id;
  String? product;
  double? price;
  String? date;
  String? location;

  ExpenseDataModel(
      {this.id,
      required this.product,
      required this.price,
      required this.date,
      required this.location});

  ExpenseDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    price = json['price'];
    date = json['date'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    data['price'] = price;
    data['date'] = date;
    data['location'] = location;
    return data;
  }
}
