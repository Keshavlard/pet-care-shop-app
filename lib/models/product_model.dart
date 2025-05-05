// lib/models/product_model.dart

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String petType;

  // Constructor
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.petType,
  });

  // Factory method to create a ProductModel from a map (for parsing the local data)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(), // Ensure price is a double
      imageUrl: json['imageUrl'],
      description: json['description'],
      petType: json['petType'],
    );
  }
}
