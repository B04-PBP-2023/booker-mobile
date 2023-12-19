// To parse this JSON data, do
//
//     final bookReview = bookReviewFromJson(jsonString);

import 'dart:convert';

List<BookReview> bookReviewFromJson(String str) =>
    List<BookReview>.from(json.decode(str).map((x) => BookReview.fromJson(x)));

String bookReviewToJson(List<BookReview> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookReview {
  int id;
  int user;
  String userName;
  int book;
  int rating;
  String reviewText;

  BookReview({
    required this.id,
    required this.user,
    required this.userName,
    required this.book,
    required this.rating,
    required this.reviewText,
  });

  factory BookReview.fromJson(Map<String, dynamic> json) => BookReview(
        id: json["id"],
        user: json["user"],
        userName: json["user_name"],
        book: json["book"],
        rating: json["rating"],
        reviewText: json["review_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "user_name": userName,
        "book": book,
        "rating": rating,
        "review_text": reviewText,
      };
}
