import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/frontpage/frontpage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewFormPage extends StatefulWidget {
  const ReviewFormPage({super.key, required this.idBuku});
  final int idBuku;

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  int _rating = 0;
  String _reviewText = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tulis Review'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    onRatingUpdate: (rating) {
                      _rating = rating.round();
                    },
                  ))
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Tuliskan Review",
                      labelText: "Tuliskan Review",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _reviewText = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Review tidak boleh kosong!";
                      }
                      return null;
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: Colors.blue,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                              "http://10.0.2.2:8000/reviewbuku/create-product-flutter/",
                              jsonEncode(<String, String>{
                                'book_id': widget.idBuku.toString(),
                                'rating': _rating.toString(),
                                'review_text': _reviewText,
                              }));
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Review berhasil disimpan!"),
                            ));
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Frontpage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                              Text("Terdapat kesalahan, silakan coba lagi."),
                            ));
                          }
                          await request.postJson(
                              "http://10.0.2.2:8000/reviewbuku/tambah_poin_flutter/",
                              jsonEncode(<String, String>{
                                'poin': "10",
                                'book_id': widget.idBuku.toString(),
                              }));
                        }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Terima kasih telah me-review, kamu mendapat 10 poin!'),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      },
                      child: const Text("Simpan"),
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}