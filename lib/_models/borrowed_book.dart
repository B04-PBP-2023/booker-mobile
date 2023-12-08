// To parse this JSON data, do
//
//     final borrowedBook = borrowedBookFromJson(jsonString);

import 'dart:convert';

List<BorrowedBook> borrowedBookFromJson(String str) =>
    List<BorrowedBook>.from(json.decode(str).map((x) => BorrowedBook.fromJson(x)));

String borrowedBookToJson(List<BorrowedBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BorrowedBook {
  String model;
  int pk;
  Fields fields;

  BorrowedBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
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
  int user;
  int book;
  DateTime startDate;
  DateTime endDate;

  Fields({
    required this.user,
    required this.book,
    required this.startDate,
    required this.endDate,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
      };
}
