import 'package:booker/frontpage/widgets/frontpage_card.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';

class PinjamBuku extends StatefulWidget {
  const PinjamBuku({super.key, required this.data, required this.index});

  final BookDataProvider data;
  final int index;

  @override
  State<PinjamBuku> createState() => _PinjamBukuState();
}

class _PinjamBukuState extends State<PinjamBuku> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Peminjaman")),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 270,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.listBook[widget.index].fields.name,
                    style: const TextStyle(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "${widget.data.listBook[widget.index].fields.author}, ${widget.data.listBook[widget.index].fields.year}",
                  ),
                  Text(
                    widget.data.listBook[widget.index].fields.genre,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                      onPressed: () {},
                      child: const Text("Pinjam"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
