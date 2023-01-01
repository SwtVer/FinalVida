import 'dart:convert';

import 'package:vida/models/productmodel.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final List<String> images;
  //final List<String> category;
  final String address;
  final String userId;
  final int orderedAt;
  final int status;
  final int cancelstatus;
  final double totalPrice;
  final String category;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.images,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.cancelstatus,
    required this.totalPrice,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'images': images,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'cancelstatus':cancelstatus,
      'totalPrice': totalPrice,
      'category': category,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
          map['products']?.map((x) => Product.fromMap(x['product']))),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      images: List<String>.from(map['images']),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
      cancelstatus: map['cancelstatus']?.toInt() ?? 0,
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
