// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

List<Book> bookFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String bookToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  int id;
  String name;
  String author;
  int rating;
  int reviews;
  int price;
  int year;
  String genre;
  int stock;
  int pointsToExchange;
  bool forSale;

  Book({
    required this.id,
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

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    name: json["name"],
    author: json["author"],
    rating: json["rating"],
    reviews: json["reviews"],
    price: json["price"],
    year: json["year"],
    genre: json["genre"],
    stock: json["stock"],
    pointsToExchange: json["points_to_exchange"],
    forSale: json["for_sale"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
