
import 'package:flutter/material.dart';

enum JenisKonten { berita, edukasi }

class Konten {
  final String id;
  final String judul;
  final String kategori;
  final String ringkasan;
  final String isi;
  final JenisKonten jenis;
  final IconData ikon;

  const Konten({
    required this.id,
    required this.judul,
    required this.kategori,
    required this.ringkasan,
    required this.isi,
    required this.jenis,
    required this.ikon,
  });
}
