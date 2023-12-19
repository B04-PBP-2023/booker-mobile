import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../_models/review.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key, required this.idReview, required int index});
  final int idReview;

  @override
  ReviewPageState createState() => ReviewPageState();
}

class ReviewPageState extends State<ReviewPage> {
  Future<List<BookReview>> fetchProduct(request) async {
    var response = await request.get('/reviewbuku/get-review-json-flutter/');

    // melakukan konversi data json menjadi object Product
    List<BookReview> listBookReview = [];
    for (var d in response) {
      if (d != null) {
        listBookReview.add(BookReview.fromJson(d));
      }
    }
    return listBookReview;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ulasan'),
      ),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Column(
                children: [
                  Text(
                    "Review masih kosong, jadilah yang pertama memberikan ulasan",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              var filteredData =
                  snapshot.data!.where((data) => data.book == widget.idReview).toList();
              return Column(
                children: [
                  Expanded(
                    child: filteredData.isEmpty
                        ? const Text(
                            "Review masih kosong, jadilah yang pertama memberikan ulasan",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          )
                        : ListView.builder(
                            itemCount: filteredData.length,
                            itemBuilder: (_, index) {
                              return Card(
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
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
                                      padding: const EdgeInsets.fromLTRB(7, 0, 20, 0),
                                      child: SmoothStarRating(
                                        starCount: 5,
                                        rating: filteredData[index].rating.toDouble(),
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.orangeAccent,
                                        size: 21.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (filteredData[index].reviewText != "")
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                                        child: Text(
                                          "${filteredData[index].reviewText}",
                                          style: const TextStyle(
                                              fontSize: 15, fontWeight: FontWeight.w500),
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
