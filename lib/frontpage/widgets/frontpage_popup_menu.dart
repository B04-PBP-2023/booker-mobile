import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../frontpage.dart';

class FrontpagePopupMenu extends StatefulWidget {
  const FrontpagePopupMenu({
    super.key,
  });

  @override
  State<FrontpagePopupMenu> createState() => _FrontpagePopupMenuState();
}

class _FrontpagePopupMenuState extends State<FrontpagePopupMenu> {
  late String username = '', points = '';

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
            alignmentOffset: Offset.fromDirection(0.0, -50),
            menuChildren: [
              MenuItemButton(
                leadingIcon: const Icon(
                  Icons.person,
                  color: Colors.black87,
                ),
                style: MenuItemButton.styleFrom(
                  disabledForegroundColor: Colors.black,
                ),
                child: Text(username),
              ),
              MenuItemButton(
                leadingIcon: const Icon(
                  Icons.diamond,
                  color: Colors.blueAccent,
                ),
                style: MenuItemButton.styleFrom(
                  disabledForegroundColor: Colors.black,
                ),
                child: Text(points),
              ),
              MenuItemButton(
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
                    if (response['status']) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(message),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Frontpage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(message),
                      ));
                    }
                  },
                  child: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.redAccent),
                  ))
            ],
            child: const Center(child: Icon(Icons.account_circle)),
          )
        ]);
  }
}
