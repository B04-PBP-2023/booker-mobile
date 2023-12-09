import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/_models/book.dart';
import 'package:booker/frontpage/widgets/frontpage_appbar.dart';
import 'package:booker/frontpage/widgets/frontpage_card.dart';
import 'package:booker/login/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  Future<List<Book>> fetchBook(CookieRequest request) async {
    var response = await request.get('http://127.0.0.1:8000/api/books');
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
    return Scaffold(
      appBar: const FrontpageAppBar(),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: FutureBuilder(
          future: fetchBook(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                shrinkWrap: true,
                childAspectRatio: 0.65,
                children: List.generate(snapshot.data!.length, (index) {
                  return FrontpageCard(
                    index: index,
                    snapshot: snapshot,
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
