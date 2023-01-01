import 'dart:convert';

class SubscriptionModel {
  final String description;
  final String userId;
  final List<String> images;
  final String category;
  final String orderedAt;
  final String? id;

  SubscriptionModel({
    required this.description,
    required this.images,
    required this.category,
    required this .orderedAt,
    required this.userId,
    this.id,

  });

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'images': images,
      'category': category,
      'userId':userId,
      'orderedAt': orderedAt,
      'id': id,
    };
  }

//Json serilization
  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
      description: map['description'] ?? '',

      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      userId: map['userId'] ?? '',
      orderedAt: map['orderedAt'] ?? '',

      id: map['_id'], //mongoose/db will give id
    );
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) =>
      SubscriptionModel.fromMap(json.decode(source));
}
