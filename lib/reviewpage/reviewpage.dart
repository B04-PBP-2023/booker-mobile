import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:booker/_models/review.dart';
import 'package:booker/_global_widgets/drawer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:booker/reviewpage/widgets/bookdata.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.idReview});
  final int idReview;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Future<List<BookReview>> fetchProduct() async {
    var url = Uri.parse('http://10.0.2.2:8000/reviewbuku/get-review-json-flutter/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<BookReview> listBookReview = [];
    for (var d in data) {
      if (d != null) {
        listBookReview.add(BookReview.fromJson(d));
      }
    }
    return listBookReview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Review masih kosong, jadilah yang pertama me-review",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              var filteredData = snapshot.data!.where((data) => data.book == widget.idReview).toList();

              return Column(
                children: [
                  BookDataCard(idBuku: widget.idReview - 1, reviewCount: filteredData.length),
                  Expanded(
                    child: filteredData.isEmpty
                        ? const Text(
                        "Review masih kosong, jadilah yang pertama me-review",
                        style: TextStyle(fontSize: 16),textAlign: TextAlign.center,
                      )
                        : ListView.builder(
                      itemCount: filteredData.length,
                      itemBuilder: (_, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    10, 10, 20, 0),
                                child: Text(
                                  "${filteredData[index].userName}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(7, 0, 20, 0),
                                child: SmoothStarRating(
                                  starCount: 5,
                                  rating: filteredData[index].rating
                                      .toDouble(),
                                  color: Colors.orangeAccent,
                                  borderColor: Colors.orangeAccent,
                                  size: 21.0,
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (filteredData[index].reviewText != "")
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 20, 10),
                                  child: Text(
                                    "${filteredData[index].reviewText}",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              if (filteredData[index].reviewText == "")
                                const SizedBox(height: 5),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
