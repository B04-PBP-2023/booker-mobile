import 'package:flutter/material.dart';
import 'package:booker/_models/book.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:booker/login/login.dart';
import 'package:booker/reviewpage/widgets/review_form.dart';

class BookDataCard extends StatefulWidget {
  const BookDataCard({super.key, required this.idBuku});
  final int idBuku;

  @override
  _BookDataCardState createState() => _BookDataCardState();
}

class _BookDataCardState extends State<BookDataCard> {
  Future<List<Book>> fetchBook(CookieRequest request) async {
    var response = await request.get('http://10.0.2.2:8000/api/books');
    List<Book> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(Book.fromJson(book));
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
            ],
          );
        });
  }
}
