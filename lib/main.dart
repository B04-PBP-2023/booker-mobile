import 'package:booker/frontpage/frontpage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import '_models/book.dart';
import 'frontpage/widgets/frontpage_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the app.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) {
          CookieRequest request = CookieRequest(
              baseUrl: true ? 'https://booker-b04-tk.pbp.cs.ui.ac.id' : 'http://10.0.2.2:8000');
          return request;
        }),
        ChangeNotifierProvider<IsSearchProvider>(create: (_) => IsSearchProvider()),
        ChangeNotifierProvider<IsSearchBookshelfProvider>(
            create: (_) => IsSearchBookshelfProvider()),
        ChangeNotifierProvider<BookDataProvider>(create: (_) => BookDataProvider()),
        ChangeNotifierProvider<UserDataProvider>(create: (_) => UserDataProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const Frontpage(),
      ),
    );
  }
}

class BookDataProvider extends ChangeNotifier {
  List<Book> _listBook = [];
  bool _loading = false;

  List<Book> get listBook => _listBook;
  bool get loading => _loading;

  Future<void> updateList(Future<List<Book>> list) async {
    _listBook = await list;
    _loading = false;
    notifyListeners();
  }

  void setLoading(bool b) {
    _loading = b;
    notifyListeners();
  }
}

class IsSearchProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  void toggleSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}

class IsSearchBookshelfProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  void toggleSearch() {
    _isSearch = !_isSearch;
    notifyListeners();
  }
}

class UserDataProvider extends ChangeNotifier {
  String _username = '';
  int _points = 0;

  String get username => _username;
  int get points => _points;

  void updateUserData(String username, int points) {
    _username = username;
    _points = points;
    notifyListeners();
  }
}
