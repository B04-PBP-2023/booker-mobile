import 'package:booker/bookshelf/bookshelf.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class BoughtCard extends StatelessWidget {
  const BoughtCard({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final BookshelfDataProvider snapshot;
  final int index;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      const Icon(
                        Icons.attach_money,
                        size: 19,
                        color: Colors.green,
                      ),
                      Text("${snapshot.listBook[index].book.price ?? '-'}",
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w500,
                          ))
                    ]),
                    Row(children: [
                      const Icon(
                        Icons.star,
                        size: 19,
                        color: Colors.orange,
                      ),
                      Text("${snapshot.listBook[index].book.rating}",
                          style: const TextStyle(
                            fontSize: 16.5,
                            fontWeight: FontWeight.w500,
                          ))
                    ]),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.blue,
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    onPressed: () {},
                    child: const Text("Beli"),
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
                    child: const Text("Pinjam"),
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
