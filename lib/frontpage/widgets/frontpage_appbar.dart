import 'package:booker/frontpage/frontpage.dart';
import 'package:booker/frontpage/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../login/login.dart';

class IsSearchProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  void toggleSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}

class FrontpageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const FrontpageAppBar({super.key});

  @override
  State<FrontpageAppBar> createState() => _FrontpageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _FrontpageAppBarState extends State<FrontpageAppBar> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return ChangeNotifierProvider<IsSearchProvider>(
        create: (_) => IsSearchProvider(),
        child: Consumer<IsSearchProvider>(
          builder: (context, provider, child) {
            if (!provider.isSearch) {
              return AppBar(
                title: const Text("Booker"),
                actions: [
                  IconButton(
                    onPressed: () => provider.toggleSearch(),
                    icon: const Icon(Icons.search),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Builder(builder: (context) {
                      if (!request.loggedIn) {
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const LoginPage()));
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.login),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Login"),
                              )
                            ],
                          ),
                        );
                      } else {
                        return ElevatedButton(
                          style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(Colors.redAccent)),
                          onPressed: () async {
                            final response = await request
                                .logout("http://127.0.0.1:8000/authentication/logout/");
                            String message = response["message"];
                            if (response['status']) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("$message"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Frontpage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("$message"),
                              ));
                            }
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.logout),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Logout"),
                              )
                            ],
                          ),
                        );
                      }
                    }),
                  )
                ],
              );
            } else {
              return AppBar(
                automaticallyImplyLeading: false,
                actions: const [
                  Expanded(child: FrontpageSearchBar()),
                ],
              );
            }
          },
        ));
  }
}
