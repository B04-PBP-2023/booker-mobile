// To parse this JSON data, do
//
//     final bookBought = bookBoughtFromJson(jsonString);

import 'dart:convert';

List<BookBought> bookBoughtFromJson(String str) => List<BookBought>.from(json.decode(str).map((x) => BookBought.fromJson(x)));

String bookBoughtToJson(List<BookBought> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookBought {
  int user;
  BoughtBook book;
  DateTime boughtDate;

  BookBought({
    required this.user,
    required this.book,
    required this.boughtDate,
  });

  factory BookBought.fromJson(Map<String, dynamic> json) => BookBought(
    user: json["user"],
    book: BoughtBook.fromJson(json["book"]),
    boughtDate: DateTime.parse(json["bought_date"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "book": book.toJson(),
    "bought_date": "${boughtDate.year.toString().padLeft(4, '0')}-${boughtDate.month.toString().padLeft(2, '0')}-${boughtDate.day.toString().padLeft(2, '0')}",
  };
}

class BoughtBook {
  int id;
  String name;
  String author;
  double rating;
  int reviews;
  int price;
  int year;
  String genre;
  int stock;
  int pointsToExchange;
  bool forSale;

  BoughtBook({
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

  factory BoughtBook.fromJson(Map<String, dynamic> json) => BoughtBook(
    id: json["id"],
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
