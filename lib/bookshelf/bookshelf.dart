import 'package:booker/_global_widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import '../frontpage/widgets/frontpage_popup_menu.dart';
import '../main.dart';

class Bookshelf extends StatefulWidget {
  const Bookshelf({super.key});

  @override
  State<Bookshelf> createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer<IsSearchBookshelfProvider>(
      builder: (context, provider, child) {
        if (!provider.isSearch) {
          return AppBar(
            title: const Text("Booker"),
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
            actions: [
              // Expanded(
              //     child: FrontpageSearchBar(
              //   fetchBook: widget.fetchBook,
              //   searchBarController: _searchBarController,
              // )),
            ],
          );
        }
      },
    );
  }
}
