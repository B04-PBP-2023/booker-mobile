import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:booker/reviewpage/reviewpage.dart';
import 'package:provider/provider.dart';
import 'package:booker/login/login.dart';

import '../../_models/book.dart';

class FrontpageCard extends StatelessWidget {
  const FrontpageCard({
    super.key,
    required this.index,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;
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
                  "${snapshot.data![index].fields.name}",
                  style: const TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                Text(
                  "${snapshot.data![index].fields.author}, ${snapshot.data![index].fields.year}",
                ),
                Text(
                  "${snapshot.data![index].fields.genre}",
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
                      Text("${snapshot.data![index].fields.price}",
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
                      Text("${snapshot.data![index].fields.rating}",
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
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      surfaceTintColor: Colors.blue,
                    ),
                    onPressed: request.loggedIn
                        ? () {
                      showDialog(
                          context: context,
                          builder: (context) => ReviewPage(idReview: index + 1));
                    }
                        : () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const LoginPage()));
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
