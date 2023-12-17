import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/login/login.dart';
import 'package:flutter/material.dart';
import 'package:booker/frontpage/frontpage.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          // const DrawerHeader(
          //   decoration: BoxDecoration(
          //     color: Colors.indigo,
          //   ),
          //   child: Column(
          //     children: [
          //       Text(
          //         'Shopping List',
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           fontSize: 30,
          //           fontWeight: FontWeight.bold,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Padding(padding: EdgeInsets.all(10)),
          //       Text(
          //         "Catat seluruh keperluan belanjamu di sini!",
          //         textAlign: TextAlign.center,
          //         style:
          //             TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
          //       ),
          //     ],
          //   ),
          // ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Frontpage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.shelves),
            title: const Text('Bookshelf'),
            onTap: () {
              if (request.loggedIn) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Bookshelf(),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              }
            },
          ),
        ],
      ),
    );
  }
}
