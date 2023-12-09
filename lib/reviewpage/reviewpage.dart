import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:booker/_models/review.dart';
import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/reviewpage/models/book.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Future<List<BookReview>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://localhost:8000/reviewbuku/get-review-json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<BookReview> list_book_review = [];
    for (var d in data) {
      if (d != null) {
        list_book_review.add(BookReview.fromJson(d));
      }
    }
    return list_book_review;
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
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 10, 20, 0),
                                child: Text(
                                  "FFFF",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text("KOKOKO"),
                      Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (_, index) => Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 20, 0),
                                          child: Text(
                                            "${snapshot.data![index].userName}",
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(7, 0, 20, 0),
                                          child: SmoothStarRating(
                                            starCount: 5,
                                            rating: snapshot.data![index].rating
                                                .toDouble(),
                                            color: Colors.orangeAccent,
                                            borderColor: Colors.orangeAccent,
                                            size: 21.0,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 20, 10),
                                          child: Text(
                                            "${snapshot.data![index].reviewText}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )))
                    ],
                  );
                }
              }
            }));
  }
}
