import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/donasi_buku/donasi.dart';
import 'package:booker/frontpage/frontpage.dart';
import 'package:booker/login/login.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '_models/borrowed_book.dart';
import '_models/bought_book.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List screens = const [
    Donasi(),
    Frontpage(),
    Bookshelf(),
  ];

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
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer<ScreenIndexProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: screens[provider.screenIndex],
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: BottomNavigationBar(
              currentIndex: provider.screenIndex,
              elevation: 1,
              selectedIconTheme: const IconThemeData(color: Colors.blueAccent),
              unselectedIconTheme: const IconThemeData(color: Colors.black54),
              selectedFontSize: 13.5,
              unselectedFontSize: 12.5,
              selectedItemColor: Colors.black87,
              unselectedItemColor: Colors.black87,
              onTap: (index) async {
                if (index == 1 || request.loggedIn) {
                  provider.updateScreenIndex(index);
                  if (index == 1) {
                    Provider.of<IsSearchProvider>(context, listen: false).toggleSearch();
                    Provider.of<IsSearchProvider>(context, listen: false).toggleSearch();
                  } else if (index == 2) {
                    final prov = Provider.of<BookshelfDataProvider>(context, listen: false);
                    if (prov.borrow) {
                      prov.setLoading(true);
                      prov.updateList(fetchBorrowed(''));
                    } else {
                      prov.setLoading(true);
                      prov.updateList(fetchBought(''));
                    }
                  }
                } else {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const LoginPage()));
                }
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: "Donasi"),
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Beranda"),
                BottomNavigationBarItem(icon: Icon(Icons.shelves), label: "Bookshelf"),
              ],
            ),
          ),
        );
      },
    );
  }
}
