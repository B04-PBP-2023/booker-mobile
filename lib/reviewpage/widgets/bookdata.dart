import 'package:booker/reviewpage/models/book_bought.dart';
import 'package:flutter/material.dart';
import 'package:booker/_models/book.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:booker/login/login.dart';
import 'package:booker/reviewpage/widgets/review_form.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:booker/reviewpage/models/book_borrow.dart';

class BookDataCard extends StatefulWidget {
  BookDataCard(
      {super.key, required this.idBuku, required this.reviewCount});
  final int idBuku;
  final int reviewCount;
  bool canReview = false;

  @override
  _BookDataCardState createState() => _BookDataCardState();
}

class _BookDataCardState extends State<BookDataCard> {
  Future<List<Book>> fetchBook(CookieRequest request) async {
    var response = await request.get('http://10.0.2.2:8000/api/books');
    var bookBorrow = await request.get('http://10.0.2.2:8000/reviewbuku/get-borrow-json/');
    var bookBought = await request.get('http://10.0.2.2:8000/reviewbuku/get-bought-json/');
    
    List<Book> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(Book.fromJson(book));
      }
    }
    List<BookBorrow> borrowedBook = [];
    for (var book in bookBorrow) {
      if (book != null) {
        borrowedBook.add(BookBorrow.fromJson(book));
        if (listBook[widget.idBuku].pk == BookBorrow.fromJson(book).book.id) {
          widget.canReview = true;
        }
      }
    }
    List<BookBought> boughtBook = [];
    for (var book in bookBought) {
      if (book != null) {
        boughtBook.add(BookBought.fromJson(book));
        if (listBook[widget.idBuku].pk == BookBought.fromJson(book).book.id) {
          widget.canReview = true;
        }
      }
    }

    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return FutureBuilder(
        future: fetchBook(request),
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                        child: Text(
                          snapshot.data![widget.idBuku].fields.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
                        child: Text(
                          "${snapshot.data![widget.idBuku].fields.author}, ${snapshot.data![widget.idBuku].fields.year}, ${snapshot.data![widget.idBuku].fields.genre}",
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: "${snapshot.data![widget.idBuku].fields.rating}",
                        style: const TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold)),
                    const TextSpan(
                        text: "/5",
                        style: TextStyle(fontSize: 20, color: Colors.grey)),
                  ],
                ),
              ),
              RatingBarIndicator(
                rating: snapshot.data![widget.idBuku].fields.rating,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
                itemCount: 5,
                itemSize: 25.0,
                direction: Axis.horizontal,
              ),
              const SizedBox(height: 2),
              Text(
                "${widget.reviewCount} reviews",
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
              if (widget.canReview)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.blue,
                            ),
                            onPressed: request.loggedIn
                                ? () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => ReviewFormPage(
                                            idBuku: widget.idBuku + 1));
                                  }
                                : () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                            child: const Text("Tulis Review"),
                          )),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              if (!widget.canReview)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Pinjam atau beli buku ini terlebih dahulu untuk me-review", textAlign: TextAlign.center),
                          )),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
            ],
          );
        });
  }
}
