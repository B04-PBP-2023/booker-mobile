import 'package:booker/frontpage/frontpage.dart';
import 'package:booker/frontpage/widgets/frontpage_appbar.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class BookshelfSearchBar extends StatefulWidget {
  const BookshelfSearchBar(
      {super.key,
      required this.fetchBorrowed,
      required this.fetchBought,
      required this.searchBarController});

  final Function fetchBorrowed;
  final Function fetchBought;
  final TextEditingController searchBarController;

  @override
  State<BookshelfSearchBar> createState() => _BookshelfSearchBarState();
}

class _BookshelfSearchBarState extends State<BookshelfSearchBar> {
  final _searchbarFocusNode = FocusNode();
  bool _isSearchPopulated = false;
  void search(String val, Function fetch, Function update) {
    update(fetch(val));
  }

  @override
  void initState() {
    super.initState();

    if (widget.searchBarController.text != '') {
      _isSearchPopulated = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future.delayed(Duration.zero, () => _searchbarFocusNode.requestFocus());
    return Center(
      child: Consumer<BookDataProvider>(
        builder: (context, provider, child) {
          return SearchBar(
            controller: widget.searchBarController,
            focusNode: _searchbarFocusNode,
            onSubmitted: (val) {
              provider.setLoading(true);
              // search(val, widget.fetchBook, provider.updateList);
            },
            onChanged: (val) {
              setState(() {
                _isSearchPopulated = true;
              });
              if (val == '') {
                setState(() {
                  _isSearchPopulated = false;
                });
                // return search(val, widget.fetchBook, provider.updateList);
              }
            },
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 4.0),
            ),
            shape: const MaterialStatePropertyAll<OutlinedBorder>(LinearBorder()),
            leading: Consumer<IsSearchProvider>(
              builder: (context, provider, child) {
                return IconButton(
                  onPressed: () {
                    provider.toggleSearch();
                  },
                  icon: const Icon(Icons.arrow_back),
                );
              },
            ),
            hintText: "Cari buku, penulis, genre...",
            trailing: [
              Builder(builder: (context) {
                if (_isSearchPopulated) {
                  return IconButton(
                    onPressed: () {
                      widget.searchBarController.clear();
                      setState(() {
                        _isSearchPopulated = false;
                      });
                      provider.setLoading(true);
                      // return search('', widget.fetchBook, provider.updateList);
                    },
                    icon: const Icon(Icons.close),
                  );
                } else {
                  return Container();
                }
              }),
            ],
          );
        },
      ),
    );
  }
}
