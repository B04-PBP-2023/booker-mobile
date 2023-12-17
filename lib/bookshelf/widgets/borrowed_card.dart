import 'package:booker/bookshelf/bookshelf.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class BorrowedCard extends StatelessWidget {
  BorrowedCard({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final BookshelfDataProvider snapshot;
  final int index;

  final df = DateFormat('d MMMM yyyy');

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
                    onPressed: () {},
                    child: const Text("Review"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.blue,
                      side: const BorderSide(color: Colors.indigoAccent),
                    ),
                    onPressed: () {},
                    child: const Text("Kembalikan"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
