import 'package:booker/_models/book.dart';
import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/review/review.dart';
import 'package:booker/review/widgets/review_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class BorrowedCard extends StatelessWidget {
  const BorrowedCard({
    super.key,
    required this.index,
    required this.snapshot,
    required this.df,
    required this.fetchBorrowed,
  });

  final BookshelfDataProvider snapshot;
  final int index;
  final DateFormat df;
  final Function fetchBorrowed;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot.listBook[index].book.name,
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "${snapshot.listBook[index].book.author}, ${snapshot.listBook[index].book.year}",
                ),
                Text(
                  snapshot.listBook[index].book.genre,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Text(
                    "Tanggal pengembalian:\n${df.format(snapshot.listBook[index].endDate)}",
                    style: const TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.blue,
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ReviewFormPage(idBuku: snapshot.listBook[index].book.id)));
                    },
                    child: const Text("Review"),
                  ),
                ),
                Consumer<BookshelfDataProvider>(builder: (context, provider, child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.blue,
                        side: const BorderSide(color: Colors.indigoAccent),
                      ),
                      onPressed: () async {
                        final response = await request.post("/pinjambuku/pengembalian/", {
                          "id": snapshot.listBook[index].book.id.toString(),
                        });
                        String message = response["message"];
                        if (response['success']) {
                          provider.setLoading(true);
                          provider.updateList(fetchBorrowed(''));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(message),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(message),
                          ));
                        }
                      },
                      child: const Text("Kembalikan"),
                    ),
                  );
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
