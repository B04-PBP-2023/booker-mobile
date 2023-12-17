import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/donasi_buku/donasi.dart';
import 'package:booker/frontpage/frontpage.dart';
import 'package:booker/frontpage/widgets/frontpage_appbar.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              onTap: (index) => provider.updateScreenIndex(index),
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
