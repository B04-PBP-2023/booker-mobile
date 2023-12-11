import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/_models/book.dart';
import 'package:booker/frontpage/widgets/frontpage_appbar.dart';
import 'package:booker/frontpage/widgets/frontpage_card.dart';
import 'package:booker/login/login.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class Frontpage extends StatefulWidget {
  const Frontpage({super.key});

  @override
  State<Frontpage> createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  Future<List<Book>> fetchBook(String query) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    if (query == '') {
      response = await request.get('/api/books/');
    } else {
      response = await request.get('/api/books/search?q=$query');
    }

    List<Book> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(Book.fromJson(book));
      }
    }

    return listBook;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookDataProvider>(
      create: (_) {
        BookDataProvider bdp = BookDataProvider();
        bdp.updateList(fetchBook(''));
        return bdp;
      },
      child: Scaffold(
        appBar: FrontpageAppBar(
          fetchBook: fetchBook,
        ),
        drawer: const LeftDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Consumer<BookDataProvider>(
            builder: (context, provider, child) {
              if (provider.listBook == []) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  shrinkWrap: true,
                  childAspectRatio: 0.65,
                  children: List.generate(provider.listBook.length, (index) {
                    return FrontpageCard(
                      index: index,
                      snapshot: provider,
                    );
                  }),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
