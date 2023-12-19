import 'package:booker/laman_admin/laman_admin.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

class FrontpagePopupMenu extends StatefulWidget {
  const FrontpagePopupMenu({
    super.key,
  });

  @override
  State<FrontpagePopupMenu> createState() => _FrontpagePopupMenuState();
}

class _FrontpagePopupMenuState extends State<FrontpagePopupMenu> {
  late String username = '', points = '';
  late bool isAdmin = false;

  @override
  void initState() {
    super.initState();
  }

  void fetchUserData() async {
    final request = Provider.of<CookieRequest>(context, listen: false);
    var response = await request.get('/authentication/user-data');
    setState(() {
      username = response['username'];
      points = response['points'].toString();
      isAdmin = response['admin'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return MenuBar(
        style: MenuStyle(
            elevation: const MaterialStatePropertyAll<double>(0),
            padding: const MaterialStatePropertyAll(EdgeInsets.zero),
            fixedSize: const MaterialStatePropertyAll(Size.infinite),
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(Colors.white.withOpacity(0))),
        children: [
          SubmenuButton(
            onOpen: () async {
              fetchUserData();
            },
            style: SubmenuButton.styleFrom(
              alignment: Alignment.center,
            ),
            alignmentOffset: Offset.fromDirection(0.0, -60),
            menuChildren: !isAdmin
                ? [
                    MenuItemButton(
                      leadingIcon: const Icon(
                        Icons.person_outlined,
                        color: Colors.black87,
                      ),
                      style: MenuItemButton.styleFrom(
                        disabledForegroundColor: Colors.black,
                      ),
                      child: Text(username),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(
                        Icons.diamond_outlined,
                        color: Colors.blueAccent,
                      ),
                      style: MenuItemButton.styleFrom(
                        disabledForegroundColor: Colors.black,
                      ),
                      child: Text(points),
                    ),
                    Consumer2<ScreenIndexProvider, IsSearchProvider>(
                        builder: (context, screenIndex, isSearch, child) {
                      return MenuItemButton(
                          leadingIcon: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          style: MenuItemButton.styleFrom(
                            disabledForegroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            final response = await request.logout("/authentication/logout-mobile/");
                            String message = response["message"];

                            if (!mounted) return;

                            if (response['status']) {
                              screenIndex.updateScreenIndex(1);
                              isSearch.toggleSearch();
                              isSearch.toggleSearch();
                              ScaffoldMessenger.of(super.context).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            }
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.redAccent),
                          ));
                    })
                  ]
                : [
                    MenuItemButton(
                      leadingIcon: const Icon(
                        Icons.person_outlined,
                        color: Colors.black87,
                      ),
                      style: MenuItemButton.styleFrom(
                        disabledForegroundColor: Colors.black,
                      ),
                      child: Text(username),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(
                        Icons.diamond_outlined,
                        color: Colors.blueAccent,
                      ),
                      style: MenuItemButton.styleFrom(
                        disabledForegroundColor: Colors.black,
                      ),
                      child: Text(points),
                    ),
                    MenuItemButton(
                      leadingIcon: const Icon(
                        Icons.admin_panel_settings_outlined,
                        color: Colors.green,
                      ),
                      style: MenuItemButton.styleFrom(
                        disabledForegroundColor: Colors.black,
                      ),
                      child: const Text('Admin'),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const LamanAdmin()));
                      },
                    ),
                    Consumer2<ScreenIndexProvider, IsSearchProvider>(
                        builder: (context, screenIndex, isSearch, child) {
                      return MenuItemButton(
                          leadingIcon: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                          ),
                          style: MenuItemButton.styleFrom(
                            disabledForegroundColor: Colors.black,
                          ),
                          onPressed: () async {
                            final response = await request.logout("/authentication/logout-mobile/");
                            String message = response["message"];

                            if (!mounted) return;

                            if (response['status']) {
                              screenIndex.updateScreenIndex(1);
                              isSearch.toggleSearch();
                              isSearch.toggleSearch();
                              ScaffoldMessenger.of(super.context).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(message),
                              ));
                            }
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.redAccent),
                          ));
                    })
                  ],
            child: const Center(child: Icon(Icons.account_circle_outlined)),
          )
        ]);
  }
}
