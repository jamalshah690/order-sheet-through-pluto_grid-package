import 'dart:convert';

// Order Model
class OrderModel {
  String customerId;
  String customerName;
  String branchName;
  String trip;
  int quantity;

  OrderModel({
    required this.customerId,
    required this.customerName,
    required this.branchName,
    required this.trip,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'branchName': branchName,
      'trip': trip,
      'quantity': quantity,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      branchName: map['branchName'] as String,
      trip: map['trip'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
