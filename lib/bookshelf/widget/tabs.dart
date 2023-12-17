import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/bookshelf/bookshelf_bought.dart';
import 'package:flutter/material.dart';

class MyTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Example'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Peminjaman'),
              Tab(text: 'Pembelian'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Bookshelf(),
            BookshelfBought(),
          ],
        ),
      ),
    );
  }
}