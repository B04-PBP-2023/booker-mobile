// To parse this JSON data, do
//
//     final boughtBook = boughtBookFromJson(jsonString);

import 'dart:convert';

List<BoughtBook> boughtBookFromJson(String str) =>
    List<BoughtBook>.from(json.decode(str).map((x) => BoughtBook.fromJson(x)));

String boughtBookToJson(List<BoughtBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoughtBook {
  String model;
  int pk;
  Fields fields;

  BoughtBook({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory BoughtBook.fromJson(Map<String, dynamic> json) => BoughtBook(
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
  DateTime boughtDate;

  Fields({
    required this.user,
    required this.book,
    required this.boughtDate,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        book: json["book"],
        boughtDate: DateTime.parse(json["bought_date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "book": book,
        "bought_date":
            "${boughtDate.year.toString().padLeft(4, '0')}-${boughtDate.month.toString().padLeft(2, '0')}-${boughtDate.day.toString().padLeft(2, '0')}",
      };
}
