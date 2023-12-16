import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/_models/bought_book.dart';
import 'package:booker/bookshelf/widget/bookshelf_appbar.dart';
import 'package:booker/bookshelf/widget/bookshelf_card.dart';
import 'package:booker/login/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookshelfBought extends StatefulWidget {
  const BookshelfBought({super.key});

  @override
  State<BookshelfBought> createState() => _BookshelfBoughtState();
}

class _BookshelfBoughtState extends State<BookshelfBought> {
  Future<List<BoughtBook>> fetchBook(CookieRequest request) async {
    var response = await request.get('http://localhost:8000/bookshelf/get-bookshelf/?borrow=0');
    List<BoughtBook> listBook = [];
    for (var book in response) {
      if (book != null) {
        print(book);
        listBook.add(BoughtBook.fromJson(book));
      }
    }

    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: const BookshelfAppBar(),
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
                  return BookshelfCard(
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
