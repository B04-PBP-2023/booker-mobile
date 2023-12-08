import 'dart:convert';

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  String name;
  String author;
  double rating;
  int reviews;
  int? price;
  int year;
  String genre;
  int stock;
  int pointsToExchange;
  bool forSale;

  Fields({
    required this.name,
    required this.author,
    required this.rating,
    required this.reviews,
    required this.price,
    required this.year,
    required this.genre,
    required this.stock,
    required this.pointsToExchange,
    required this.forSale,
  });

  factory Fields.fromRawJson(String str) => Fields.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        author: json["author"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"],
        price: json["price"],
        year: json["year"],
        genre: json["genre"],
        stock: json["stock"],
        pointsToExchange: json["points_to_exchange"],
        forSale: json["for_sale"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "author": author,
        "rating": rating,
        "reviews": reviews,
        "price": price,
        "year": year,
        "genre": genre,
        "stock": stock,
        "points_to_exchange": pointsToExchange,
        "for_sale": forSale,
      };
}
