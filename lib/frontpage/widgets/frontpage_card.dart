import 'package:booker/frontpage/frontpage.dart';
import 'package:flutter/material.dart';

import '../../_models/book.dart';
import '../../main.dart';

class FrontpageCard extends StatelessWidget {
  const FrontpageCard({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final BookDataProvider snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
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
                  "${snapshot.listBook[index].fields.name}",
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "${snapshot.listBook[index].fields.author}, ${snapshot.listBook[index].fields.year}",
                ),
                Text(
                  "${snapshot.listBook[index].fields.genre}",
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
                      Text("${snapshot.listBook[index].fields.price}",
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
                      Text("${snapshot.listBook[index].fields.rating}",
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
