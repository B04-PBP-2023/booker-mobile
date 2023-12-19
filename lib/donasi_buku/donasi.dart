import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

class Donasi extends StatefulWidget {
  const Donasi({super.key});

  @override
  State<Donasi> createState() => _DonasiState();
}

class _DonasiState extends State<Donasi> {
  final _nameController = TextEditingController();
  final _authorController = TextEditingController();
  final _yearController = TextEditingController();
  final _genreController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('Donasi Buku')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 15.0),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Judul',
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
                  controller: _authorController,
                  decoration: const InputDecoration(
                    labelText: 'Penulis',
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
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Tahun Terbit',
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
                  controller: _genreController,
                  decoration: const InputDecoration(
                    labelText: 'Genre',
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
                const Text(
                  "Kamu akan mendapatkan 50 poin setelah mendonasikan buku.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var response = await request.post('/donasibuku/donasi-mobile/', {
                        "name": _nameController.text,
                        "author": _authorController.text,
                        "year": _yearController.text,
                        "genre": _genreController.text,
                      });

                      if (response['success']) {
                        if (!mounted) return;

                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(const SnackBar(content: Text("Donasi buku berhasil!")));
                        _nameController.clear();
                        _authorController.clear();
                        _yearController.clear();
                        _genreController.clear();
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.blueAccent),
                  ),
                  child: const Text('Donasi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
