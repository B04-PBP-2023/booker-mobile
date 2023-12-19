import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

import '../main.dart';

void main() {
  runApp(const DaftarApp());
}

class DaftarApp extends StatelessWidget {
  const DaftarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DaftarPage(),
    );
  }
}

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          helperText:
                              'Wajib diisi. Maksimal 150 karakter. Hanya alfanumerik dan simbol (@/./+/-/_./)',
                          helperMaxLines: 2,
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 12.0),
                      TextFormField(
                        controller: _password2Controller,
                        decoration: const InputDecoration(
                          labelText: 'Konfirmasi Password',
                          helperText: 'Masukkan password kembali untuk konfirmasi.',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tidak boleh kosong';
                          }
                          return null;
                        },
                        obscureText: true,
                      ),
                      const SizedBox(height: 24.0),
                      Consumer<IsSearchProvider>(builder: (context, provider, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String username = _usernameController.text;
                              String password = _passwordController.text;
                              String password2 = _password2Controller.text;

                              // for localhost, use http://10.0.2.2/
                              final response =
                                  await request.post("/authentication/signup-mobile/", {
                                'username': username,
                                'password1': password,
                                'password2': password2,
                              });

                              if (response['status']) {
                                final response =
                                    await request.login("/authentication/login-mobile/", {
                                  'username': username,
                                  'password': password,
                                });

                                // String message = response['message'];
                                String uname = response['username'];
                                provider.toggleSearch();
                                provider.toggleSearch();
                                Navigator.pop(context);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(
                                      SnackBar(content: Text("Selamat datang, $uname.")));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Pendaftaran Gagal'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(response['errors'].length,
                                          (index) => Text(response['errors'][index])),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                          ),
                          child: const Text('Daftar'),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
