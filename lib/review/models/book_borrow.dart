// To parse this JSON data, do
//
//     final bookBorrow = bookBorrowFromJson(jsonString);

import 'dart:convert';

List<BookBorrow> bookBorrowFromJson(String str) =>
    List<BookBorrow>.from(json.decode(str).map((x) => BookBorrow.fromJson(x)));

String bookBorrowToJson(List<BookBorrow> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookBorrow {
  int user;
  BookBorrowed book;
  DateTime startDate;
  DateTime endDate;

  BookBorrow({
    required this.user,
    required this.book,
    required this.startDate,
    required this.endDate,
  });

  factory BookBorrow.fromJson(Map<String, dynamic> json) => BookBorrow(
        user: json["user"],
        book: BookBorrowed.fromJson(json["book"]),
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book.toJson(),
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}

class BookBorrowed {
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

  BookBorrowed({
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

  factory BookBorrowed.fromJson(Map<String, dynamic> json) => BookBorrowed(
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
