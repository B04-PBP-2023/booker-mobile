import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class FrontpageSearchBar extends StatefulWidget {
  const FrontpageSearchBar({super.key, required this.fetchBook, required this.searchBarController});

  final Function fetchBook;
  final TextEditingController searchBarController;

  @override
  State<FrontpageSearchBar> createState() => _FrontpageSearchBarState();
}

class _FrontpageSearchBarState extends State<FrontpageSearchBar> {
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
    Future.delayed(Duration.zero, () => _searchbarFocusNode.requestFocus());
    return Center(
      child: Consumer<BookDataProvider>(
        builder: (context, provider, child) {
          return SearchBar(
            controller: widget.searchBarController,
            focusNode: _searchbarFocusNode,
            elevation: const MaterialStatePropertyAll(1),
            onSubmitted: (val) {
              provider.setLoading(true);
              search(val, widget.fetchBook, provider.updateList);
            },
            onChanged: (val) {
              setState(() {
                _isSearchPopulated = true;
              });
              if (val == '') {
                setState(() {
                  _isSearchPopulated = false;
                });
                return search(val, widget.fetchBook, provider.updateList);
              }
            },
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 4.0),
            ),
            shape: const MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))),
            ),
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
                      return search('', widget.fetchBook, provider.updateList);
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
