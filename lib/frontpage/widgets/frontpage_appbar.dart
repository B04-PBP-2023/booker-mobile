import 'package:booker/frontpage/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import '../../login/login.dart';
import '../../main.dart';
import 'frontpage_popup_menu.dart';

class FrontpageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FrontpageAppBar({super.key, required this.fetchBook});

  final Function fetchBook;

  @override
  State<FrontpageAppBar> createState() => _FrontpageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FrontpageAppBarState extends State<FrontpageAppBar> {
  final TextEditingController _searchBarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer<IsSearchProvider>(
      builder: (context, provider, child) {
        if (!provider.isSearch) {
          return AppBar(
            title: const Text("Booker"),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
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
              Builder(builder: (context) {
                if (!request.loggedIn) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.login),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Login"),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              })
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
                  child: FrontpageSearchBar(
                fetchBook: widget.fetchBook,
                searchBarController: _searchBarController,
              )),
            ],
          );
        }
      },
    );
  }
}
