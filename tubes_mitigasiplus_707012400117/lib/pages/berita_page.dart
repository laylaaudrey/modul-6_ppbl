
import 'package:flutter/material.dart';

import '../data/data_contoh.dart';
import '../models/konten.dart';
import '../widgets/kartu_konten.dart';

class BeritaPage extends StatefulWidget {
  const BeritaPage({super.key});

  @override
  State<BeritaPage> createState() {
    return _BeritaPageState();
  }
}

class _BeritaPageState extends State<BeritaPage> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {
    final daftar = DataContoh.konten.where((item) {
      return item.jenis == JenisKonten.berita &&
          (item.judul.toLowerCase().contains(
                pencarian.toLowerCase(),
              ) ||
              item.kategori.toLowerCase().contains(
                pencarian.toLowerCase(),
              ));
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (nilai) {
              setState(() {
                pencarian = nilai;
              });
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari berita atau kategori...',
            ),
          ),
        ),
        Expanded(
          child: daftar.isEmpty
              ? const Center(
                  child: Text(
                    'Tidak ada berita yang cocok.',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: daftar.length,
                  itemBuilder: (context, index) {
                    return KartuKonten(
                      konten: daftar[index],
                    );
                  },
                ),
        ),
      ],
    );
  }
}
