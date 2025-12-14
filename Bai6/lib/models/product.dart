class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final String category;
  final double rating;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] ?? {};

    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      category: json['category'] ?? '',
      rating: (ratingJson['rate'] ?? 0.0).toDouble(),
      ratingCount: ratingJson['count'] ?? 0,
    );
  }
}
