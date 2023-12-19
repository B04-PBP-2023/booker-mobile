import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../main.dart';
import '../../review/widgets/review_form.dart';

class BoughtCard extends StatelessWidget {
  const BoughtCard({
    super.key,
    required this.index,
    required this.snapshot,
    required this.df,
    required this.fetchBought,
  });

  final BookshelfDataProvider snapshot;
  final int index;
  final DateFormat df;
  final Function fetchBought;

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
                    "Tanggal pembelian:\n${df.format(snapshot.listBook[index].boughtDate)}",
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
              ],
            )
          ],
        ),
      ),
    );
  }
}
