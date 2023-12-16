import 'package:booker/bookshelf/bookshelf.dart';
import 'package:booker/frontpage/widgets/frontpage_card.dart';
import 'package:booker/main.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth_extended/pbp_django_auth_extended.dart';
import 'package:provider/provider.dart';

class PinjamBuku extends StatefulWidget {
  const PinjamBuku({super.key, required this.data, required this.index});

  final BookDataProvider data;
  final int index;

  @override
  State<PinjamBuku> createState() => _PinjamBukuState();
}

class _PinjamBukuState extends State<PinjamBuku> {
  var values = [1, 2, 3, 4, 5, 6, 7];
  final dropdownController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
              DropdownMenu<int>(
                  initialSelection: 1,
                  label: const Text("Durasi (Hari)"),
                  controller: dropdownController,
                  dropdownMenuEntries: values.map<DropdownMenuEntry<int>>((int i) {
                    return DropdownMenuEntry(value: i, label: i.toString());
                  }).toList()),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                      onPressed: () async {
                        dynamic response = await request.post('/pinjambuku/peminjaman/', {
                          'id': widget.data.listBook[widget.index].pk.toString(),
                          'durasi': dropdownController.text.toString()
                        });
                        if (response['created'] == true) {
                          Navigator.pop(context);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Bookshelf()));
                        } else {
                          Navigator.pop(context);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Gagal'),
                              content: Text(response['message']),
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
                      },
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
