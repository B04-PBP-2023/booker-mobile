import 'package:booker/_global_widgets/drawer.dart';
import 'package:booker/_models/book.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class LamanAdmin extends StatefulWidget {
  const LamanAdmin({super.key});

  @override
  State<LamanAdmin> createState() => _LamanAdminState();
}

class _LamanAdminState extends State<LamanAdmin> {
  Map<String, double> map_author = {};
  Map<String, double> map_year = {};
  Map<String, double> map_genre = {};
  Future<List<Book>> fetchBook() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');

    List<Book> list_book = [];

    for (var b in response) {
      if (b != null) {
        list_book.add(Book.fromJson(b));
        String b_author = Book.fromJson(b).fields.author;
        String b_year = Book.fromJson(b).fields.year.toString();
        String b_genre = Book.fromJson(b).fields.genre;
        map_author[b_author] = (map_author[b_author] ?? 0) + 1;
        map_year[b_year] = (map_year[b_year] ?? 0) + 1;
        map_genre[b_genre] = (map_genre[b_genre] ?? 0) + 1;
      }
    }
    return list_book;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booker'),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Data Stok Buku',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            FutureBuilder(
              future: fetchBook(),
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
                      columns: [
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
            SizedBox(height: 20),
            Text(
              'Data Grafik Buku',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tabel Data Author',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            FutureBuilder(
              future: fetchBook(),
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
                    return PieChart(
                      dataMap: map_author,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          showLegendsInRow: true,
                          legendTextStyle: TextStyle(fontSize: 8)),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Tabel Data Year',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            FutureBuilder(
              future: fetchBook(),
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
                    return PieChart(
                      dataMap: map_year,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: LegendOptions(
                          legendTextStyle: TextStyle(fontSize: 12)),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Tabel Data Genre',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            FutureBuilder(
              future: fetchBook(),
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
                    return PieChart(
                      dataMap: map_genre,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          showLegendsInRow: true),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
