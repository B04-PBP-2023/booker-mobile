import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/donasi_buku/donasi.dart';
import 'package:booker/frontpage/frontpage.dart';
import 'package:booker/login/login.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import '_models/borrowed_book.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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
              onTap: (index) {
                if (index == 1 || request.loggedIn) {
                  provider.updateScreenIndex(index);
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
