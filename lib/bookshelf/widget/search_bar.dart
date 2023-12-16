import 'package:booker/bookshelf/widget/bookshelf_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookshelfSearchBar extends StatefulWidget {
  const BookshelfSearchBar({super.key});

  @override
  State<BookshelfSearchBar> createState() => _FrontpageSearchBarState();
}

class _FrontpageSearchBarState extends State<BookshelfSearchBar> {
  final searchbarFocusNode = FocusNode();
  final searchbarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => searchbarFocusNode.requestFocus());
    return Center(
      child: SearchBar(
        controller: searchbarController,
        focusNode: searchbarFocusNode,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
          EdgeInsets.symmetric(horizontal: 16.0),
        ),
        shape: const MaterialStatePropertyAll<OutlinedBorder>(LinearBorder()),
        leading: const Icon(Icons.search),
        hintText: "Cari buku, penulis, genre...",
        trailing: [
          Consumer<IsSearchProvider>(
            builder: (context, provider, child) {
              return IconButton(
                onPressed: () => provider.toggleSearch(),
                icon: const Icon(Icons.close),
              );
            },
          ),
        ],
      ),
    );
  }
}
