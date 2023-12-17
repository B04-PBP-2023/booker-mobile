import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/_models/borrowed_book.dart';
import 'package:booker/bookshelf/widget/bookshelf_appbar.dart';
import 'package:booker/bookshelf/widget/bookshelf_card.dart';
import 'package:booker/login/login.dart';
import 'package:booker/reviewpage/models/book_bought.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> with SingleTickerProviderStateMixin {
  Future<List<BorrowedBook>> fetchBook(CookieRequest request) async {
    var response = await request.get('http://localhost:8000/bookshelf/get-bookshelf/?borrow=1');
    List<BorrowedBook> listBook = [];
    for (var book in response) {
      if (book != null) {
        print(book);
        listBook.add(BorrowedBook.fromJson(book));
      }
    }

    return listBook;
  }

  Future<List<BoughtBook>> fetchBookBought(CookieRequest request) async {
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

  late TabController _tabController;
  late CookieRequest borrowingRequest;
  late CookieRequest buyingRequest;

    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 2, vsync: this);
      borrowingRequest = context.read<CookieRequest>();
      buyingRequest = context.read<CookieRequest>();
    }

    @override
    void dispose() {
      _tabController.dispose();
      super.dispose();
    }

  Widget build(BuildContext context) {
    // final request = context.watch<CookieRequest>();
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bookshelf'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Peminjaman'),
              Tab(text: 'Pembelian'),
            ],
          ),
        ),
        drawer: const LeftDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Peminjaman Tab
                    FutureBuilder(
                      future: fetchBook(borrowingRequest),
                      builder: (context, AsyncSnapshot<List<BorrowedBook>> snapshot) {
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

                    // Pembelian Tab
                    // You can add a different widget or content for the Pembelian tab
                    FutureBuilder(
                      future: fetchBookBought(buyingRequest),
                      builder: (context, AsyncSnapshot<List<BoughtBook>> snapshot) {
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

