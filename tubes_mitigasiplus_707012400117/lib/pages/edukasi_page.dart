
import 'package:flutter/material.dart';

import '../data/data_contoh.dart';
import '../models/konten.dart';
import '../widgets/kartu_konten.dart';

class EdukasiPage extends StatefulWidget {
  const EdukasiPage({super.key});

  @override
  State<EdukasiPage> createState() {
    return _EdukasiPageState();
  }
}

class _EdukasiPageState extends State<EdukasiPage> {
  String kategori = 'Semua';
  String pencarian = '';

  final kategoriPilihan = const [
    'Semua',
    'Gempa Bumi',
    'Banjir',
    'Pertolongan Pertama',
    'Kesiapsiagaan',
  ];

  @override
  Widget build(BuildContext context) {
    final daftar = DataContoh.konten.where((item) {
      return item.jenis == JenisKonten.edukasi &&
          (kategori == 'Semua' ||
              item.kategori == kategori) &&
          (item.judul.toLowerCase().contains(
                pencarian.toLowerCase(),
              ) ||
              item.ringkasan.toLowerCase().contains(
                pencarian.toLowerCase(),
              ));
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            16, 16, 16, 6,
          ),
          child: TextField(
            onChanged: (nilai) {
              setState(() {
                pencarian = nilai;
              });
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Cari materi edukasi...',
            ),
          ),
        ),

        SizedBox(
          height: 54,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: kategoriPilihan.length,
            separatorBuilder: (_, __) {
              return const SizedBox(width: 8);
            },
            itemBuilder: (context, index) {
              final nilai = kategoriPilihan[index];

              return ChoiceChip(
                label: Text(nilai),
                selected: kategori == nilai,
                onSelected: (_) {
                  setState(() {
                    kategori = nilai;
                  });
                },
              );
            },
          ),
        ),

        Expanded(
          child: daftar.isEmpty
              ? const Center(
                  child: Text(
                    'Materi tidak ditemukan.',
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
