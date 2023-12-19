import 'package:booker/_models/borrowed_book.dart';
import 'package:booker/_models/bought_book.dart';
import 'package:booker/bookshelf/widgets/bookshelf_appbar.dart';
import 'package:booker/bookshelf/widgets/borrowed_card.dart';
import 'package:booker/bookshelf/widgets/bought_card.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../main.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  final _bookshelfSearchbarController = TextEditingController();
  late DateFormat df;

  Future<List<BorrowedBook>> fetchBorrowed(String query) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    if (query == '') {
      response = await request.get('/bookshelf/get-bookshelf?borrow=1');
    } else {
      response = await request.get('/bookshelf/search_bookshelf?borrow=1&q=$query');
    }

    List<BorrowedBook> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(BorrowedBook.fromJson(book));
      }
    }

    return listBook;
  }

  Future<List<BoughtBook>> fetchBought(String query) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    if (query == '') {
      response = await request.get('/bookshelf/get-bookshelf?borrow=0');
    } else {
      response = await request.get('/bookshelf/search_bookshelf?borrow=0&q=$query');
    }

    List<BoughtBook> listBook = [];
    for (var book in response) {
      if (book != null) {
        listBook.add(BoughtBook.fromJson(book));
      }
    }

    return listBook;
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    df = DateFormat('d MMMM yyyy', 'id');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookshelfDataProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: BookshelfAppBar(
          fetchBorrowed: fetchBorrowed,
          fetchBought: fetchBought,
          bookshelfSearchbarController: _bookshelfSearchbarController,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Center(
                child: ToggleButtons(
                  isSelected: [provider.borrow, !(provider.borrow)],
                  onPressed: (val) {
                    if ((val == 0 ? true : false) != provider.borrow) {
                      provider.setBorrow(val == 0 ? true : false);
                      if (provider.borrow) {
                        provider.setLoading(true);
                        provider.updateList(fetchBorrowed(''));
                      } else {
                        provider.setLoading(true);
                        provider.updateList(fetchBought(''));
                      }
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  children: [
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 36) / 3,
                      child: const Text(
                        "Dipinjam",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 36) / 3,
                      child: const Text(
                        "Dibeli",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: Builder(
                  builder: (context) {
                    if (provider.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (provider.listBook.isEmpty) {
                        return const Center(child: Text("Buku tidak ditemukan"));
                      } else {
                        return GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          shrinkWrap: true,
                          childAspectRatio: 0.65,
                          children: List.generate(provider.listBook.length, (index) {
                            if (provider.borrow) {
                              return BorrowedCard(
                                index: index,
                                snapshot: provider,
                                df: df,
                                fetchBorrowed: fetchBorrowed,
                              );
                            } else {
                              return BoughtCard(
                                index: index,
                                snapshot: provider,
                                df: df,
                                fetchBought: fetchBought,
                              );
                            }
                          }),
                        );
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
