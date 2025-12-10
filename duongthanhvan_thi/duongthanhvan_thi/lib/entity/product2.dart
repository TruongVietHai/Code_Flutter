class Product2 {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Rating rating; // Thêm lại trường rating

  Product2({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating, // Thêm lại trường rating
  });

  factory Product2.fromJson(Map<String, dynamic> json) {
    return Product2(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: Rating(
        rate: json['rating']['rate'].toDouble(),
        count: json['rating']['count'],
      ),
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }
}
