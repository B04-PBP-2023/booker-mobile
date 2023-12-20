import 'package:booker/_models/book.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:booker/laman_admin/widgets/laman_admin_piechart.dart';

class LamanAdmin extends StatefulWidget {
  const LamanAdmin({super.key});

  @override
  State<LamanAdmin> createState() => _LamanAdminState();
}

class _LamanAdminState extends State<LamanAdmin> {
  TextEditingController searchbar = TextEditingController();
  String query = "";
  Future<List<Book>> fetchBook(String query) async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');

    List<Book> listBook = [];
    for (var b in response) {
      if (b != null) {
        Book book = Book.fromJson(b);
        if (query != "") {
          if (book.fields.name.toLowerCase().contains(query.toLowerCase()) ||
              book.fields.author.toLowerCase().contains(query.toLowerCase()) ||
              book.fields.genre.toLowerCase().contains(query.toLowerCase())) {
            listBook.add(book);
          }
        } else {
          listBook.add(book);
        }
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Data Stok Buku',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: searchbar,
              decoration: InputDecoration(
                hintText: 'Cari buku, penulis, genre...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      query = searchbar.text;
                      searchbar.clear();
                    });
                  },
                ),
              ),
            ),
            FutureBuilder(
              future: fetchBook(query),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text("Tidak ada data produk."),
                      ],
                    );
                  } else {
                    return DataTable(
                      dataRowMaxHeight: double.infinity,
                      columns: const [
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Author')),
                        DataColumn(label: Text('Stock'))
                      ],
                      rows: List.generate(snapshot.data!.length, (index) {
                        final Book book = snapshot.data![index];
                        return DataRow(
                          cells: [
                            DataCell(Text(book.fields.name)),
                            DataCell(Text(book.fields.author)),
                            DataCell(Text(book.fields.stock.toString())),
                          ],
                        );
                      }).toList(),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Data Grafik Buku',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const LamanAdminPiechart(),
          ],
        ),
      ),
    );
  }
}
