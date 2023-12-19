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
  Map<String, double> mapAuthor = {};
  Map<String, double> mapYear = {};
  Map<String, double> mapGenre = {};
  Future<List<Book>> fetchBook() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');

    List<Book> listBook = [];

    for (var b in response) {
      if (b != null) {
        listBook.add(Book.fromJson(b));
        String bAuthor = Book.fromJson(b).fields.author;
        String bYear = Book.fromJson(b).fields.year.toString();
        String bGenre = Book.fromJson(b).fields.genre;
        mapAuthor[bAuthor] = (mapAuthor[bAuthor] ?? 0) + 1;
        mapYear[bYear] = (mapYear[bYear] ?? 0) + 1;
        mapGenre[bGenre] = (mapGenre[bGenre] ?? 0) + 1;
      }
    }
    return listBook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin'),
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
            const SizedBox(height: 20),
            const Text(
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
                      dataMap: mapAuthor,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          showLegendsInRow: true,
                          legendTextStyle: TextStyle(fontSize: 8)),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
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
                      dataMap: mapYear,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: const LegendOptions(legendTextStyle: TextStyle(fontSize: 12)),
                    );
                  }
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(
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
                      dataMap: mapGenre,
                      baseChartColor: Colors.grey[300]!,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.bottom, showLegendsInRow: true),
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
