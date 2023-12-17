import 'package:flutter/material.dart';

import '../../_models/book.dart';

class BookshelfCard extends StatelessWidget {
  const BookshelfCard({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
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
                  "${snapshot.data![index].book.name}",
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "${snapshot.data![index].book.author}, ${snapshot.data![index].book.year}",
                ),
                Text(
                  "${snapshot.data![index].book.genre}",
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
                      Text("${snapshot.data![index].book.price}",
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
                      Text("${snapshot.data![index].book.rating}",
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
                    child: const Text("Kembalikan"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.blue,
                    ),
                    onPressed: () {},
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
