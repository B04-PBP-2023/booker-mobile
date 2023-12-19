import 'package:booker/frontpage/widgets/frontpage_card.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../_models/bought_book.dart';

class BeliBuku extends StatefulWidget {
  const BeliBuku({super.key, required this.data, required this.index});

  final BookDataProvider data;
  final int index;

  @override
  State<BeliBuku> createState() => _BeliBukuState();
}

class _BeliBukuState extends State<BeliBuku> {
  Future<List<BoughtBook>> fetchBought(String query) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    if (query == '') {
      response = await request.get('/bookshelf/get-bookshelf?borrow=0');
    } else {
      response = await request.get('/bookshelf/search_bookshelf?borrow=0&q=$query');
    }

    List<BoughtBook> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(BoughtBook.fromJson(book));
      }
    }

    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer2<ScreenIndexProvider, BookshelfDataProvider>(
      builder: (context, screenIndexProvider, bookshelfProvider, child) {
        return AlertDialog(
          title: const Center(child: Text("Pembelian")),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data.listBook[widget.index].fields.name,
                        style: const TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${widget.data.listBook[widget.index].fields.author}, ${widget.data.listBook[widget.index].fields.year}",
                      ),
                      Text(
                        widget.data.listBook[widget.index].fields.genre,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.attach_money,
                              size: 22,
                              color: Colors.green,
                            ),
                            Text("${widget.data.listBook[widget.index].fields.price ?? '-'}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                          onPressed: () async {
                            dynamic response = await request.post('/belibuku/pembelian/', {
                              'id': widget.data.listBook[widget.index].pk.toString(),
                            });
                            if (response['created'] == true) {
                              Navigator.pop(context);
                              bookshelfProvider.setBorrow(false);
                              bookshelfProvider.setLoading(true);
                              bookshelfProvider.updateList(fetchBought(''));
                              screenIndexProvider.updateScreenIndex(2);
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(content: Text(response['message'])));
                            } else {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Gagal'),
                                  content: Text(response['message']),
                                  actions: [
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: const Text("Beli"),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.indigoAccent),
                          ),
                          onPressed: () {},
                          child: const Text("Tukar dengan 100 poin"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
