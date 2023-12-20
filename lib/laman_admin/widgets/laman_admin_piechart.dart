import 'package:booker/_models/book.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

class LamanAdminPiechart extends StatefulWidget {
  const LamanAdminPiechart({super.key});

  @override
  State<LamanAdminPiechart> createState() => _LamanAdminPiechartState();
}

class _LamanAdminPiechartState extends State<LamanAdminPiechart> {
  Future<Map<String, double>> fetchAuthor() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');
    Map<String, double> map_author = {};
    for (var b in response) {
      if (b != null) {
        String b_author = Book.fromJson(b).fields.author;
        map_author[b_author] = (map_author[b_author] ?? 0) + 1;
      }
    }
    return map_author;
  }

  Future<Map<String, double>> fetchYear() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');
    Map<String, double> map_year = {};
    for (var b in response) {
      if (b != null) {
        String b_year = Book.fromJson(b).fields.year.toString();
        map_year[b_year] = (map_year[b_year] ?? 0) + 1;
      }
    }
    return map_year;
  }

  Future<Map<String, double>> fetchGenre() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');
    Map<String, double> map_genre = {};
    for (var b in response) {
      if (b != null) {
        String b_genre = Book.fromJson(b).fields.genre;
        map_genre[b_genre] = (map_genre[b_genre] ?? 0) + 1;
      }
    }
    return map_genre;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Tabel Data Author',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        FutureBuilder(
          future: fetchAuthor(),
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
                  dataMap: snapshot.data,
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
          future: fetchYear(),
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
                  dataMap: snapshot.data,
                  baseChartColor: Colors.grey[300]!,
                  legendOptions:
                      LegendOptions(legendTextStyle: TextStyle(fontSize: 12)),
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
          future: fetchGenre(),
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
                  dataMap: snapshot.data,
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
    ));
  }
}
