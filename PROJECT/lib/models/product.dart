class Product {
  final String name;
  final String images;
  final double rating;
  final String createdAt;

  Product({required this.name, required this.images,required this.rating, required this.createdAt});

  factory Product.fromJson(dynamic json) {
    return Product(
        name: json['name'] as String,
        images: json['images'][0]['hostedLargeUrl'] as String,
        rating: json['rating'] as double,
        createdAt: json['createdAt'] as String);
  }

  static List<Product> productsFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Product.fromJson(data);
    }).toList();
  }

  @override
  String toString(){
    return 'Product {name: $name,image: $images, rating: $rating, createdAt: $createdAt}';
  }
}