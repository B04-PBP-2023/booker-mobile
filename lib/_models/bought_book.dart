import 'dart:convert';

class BoughtBook {
  int user;
  Book book;
  DateTime boughtDate;

  BoughtBook({
    required this.user,
    required this.book,
    required this.boughtDate,
  });

  factory BoughtBook.fromRawJson(String str) => BoughtBook.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BoughtBook.fromJson(Map<String, dynamic> json) => BoughtBook(
        user: json["user"],
        book: Book.fromJson(json["book"]),
        boughtDate: DateTime.parse(json["bought_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book.toJson(),
        "bought_date":
            "${boughtDate.year.toString().padLeft(4, '0')}-${boughtDate.month.toString().padLeft(2, '0')}-${boughtDate.day.toString().padLeft(2, '0')}",
      };
}

class Book {
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

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
