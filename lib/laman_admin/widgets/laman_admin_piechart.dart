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
    Map<String, double> mapAuthor = {};
    for (var b in response) {
      if (b != null) {
        String bAuthor = Book.fromJson(b).fields.author;
        mapAuthor[bAuthor] = (mapAuthor[bAuthor] ?? 0) + 1;
      }
    }
    return mapAuthor;
  }

  Future<Map<String, double>> fetchYear() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');
    Map<String, double> mapYear = {};
    for (var b in response) {
      if (b != null) {
        String bYear = Book.fromJson(b).fields.year.toString();
        mapYear[bYear] = (mapYear[bYear] ?? 0) + 1;
      }
    }
    return mapYear;
  }

  Future<Map<String, double>> fetchGenre() async {
    final request = Provider.of<CookieRequest>(context, listen: false);

    var response = [];
    response = await request.get('/api/books/');
    Map<String, double> mapGenre = {};
    for (var b in response) {
      if (b != null) {
        String bGenre = Book.fromJson(b).fields.genre;
        mapGenre[bGenre] = (mapGenre[bGenre] ?? 0) + 1;
      }
    }
    return mapGenre;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(height: 20),
        const Text(
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
                  legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom, showLegendsInRow: true),
                );
              }
            }
          },
        ),
      ],
    ));
  }
}
