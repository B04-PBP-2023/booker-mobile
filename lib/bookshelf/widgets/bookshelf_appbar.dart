import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../../frontpage/widgets/frontpage_popup_menu.dart';
import '../../main.dart';
import 'bookshelf_search_bar.dart';

class BookshelfAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BookshelfAppBar(
      {super.key,
      required this.fetchBorrowed,
      required this.fetchBought,
      required this.bookshelfSearchbarController});

  final Function fetchBorrowed, fetchBought;
  final TextEditingController bookshelfSearchbarController;

  @override
  State<BookshelfAppBar> createState() => _BookshelfAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BookshelfAppBarState extends State<BookshelfAppBar> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer<IsSearchBookshelfProvider>(
      builder: (context, provider, child) {
        if (!provider.isSearch) {
          return AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
            title: const Text("Bookshelf"),
            actions: [
              IconButton(
                onPressed: () => provider.toggleSearch(),
                icon: const Icon(Icons.search),
              ),
              Builder(builder: (context) {
                if (request.loggedIn) {
                  return const FrontpagePopupMenu();
                } else {
                  return Container();
                }
              }),
            ],
          );
        } else {
          return AppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
            actions: [
              Expanded(
                  child: BookshelfSearchBar(
                searchBarController: widget.bookshelfSearchbarController,
                fetchBorrowed: widget.fetchBorrowed,
                fetchBought: widget.fetchBought,
              )),
            ],
          );
        }
      },
    );
  }
}
