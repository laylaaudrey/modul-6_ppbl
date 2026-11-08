
import 'package:flutter/material.dart';

class Layanan {
  final String nama;
  final String bidang;
  final String deskripsi;
  final IconData ikon;

  const Layanan({
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.ikon,
  });
}

class DataLayanan {
  static const List<Layanan> semua = [
    Layanan(
      nama: 'Pembuatan KTP',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan pembuatan dan pembaruan '
          'Kartu Tanda Penduduk.',
      ikon: Icons.badge_outlined,
    ),
    Layanan(
      nama: 'Pembuatan Kartu Keluarga',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan pembuatan dan perubahan '
          'data Kartu Keluarga.',
      ikon: Icons.family_restroom,
    ),
    Layanan(
      nama: 'Izin Usaha',
      bidang: 'Perizinan',
      deskripsi:
          'Layanan informasi dan pengajuan '
          'perizinan usaha.',
      ikon: Icons.business_center_outlined,
    ),
    Layanan(
      nama: 'Pendaftaran Puskesmas',
      bidang: 'Kesehatan',
      deskripsi:
          'Layanan pendaftaran pemeriksaan '
          'kesehatan di Puskesmas.',
      ikon: Icons.local_hospital_outlined,
    ),
    Layanan(
      nama: 'Informasi BPJS',
      bidang: 'Kesehatan',
      deskripsi:
          'Layanan informasi kepesertaan '
          'jaminan kesehatan.',
      ikon: Icons.health_and_safety_outlined,
    ),
    Layanan(
      nama: 'Jadwal Imunisasi',
      bidang: 'Kesehatan',
      deskripsi:
          'Informasi jadwal dan pendaftaran '
          'layanan imunisasi.',
      ikon: Icons.vaccines_outlined,
    ),
    Layanan(
      nama: 'Informasi Bus Kota',
      bidang: 'Transportasi',
      deskripsi:
          'Informasi rute dan jadwal '
          'transportasi bus kota.',
      ikon: Icons.directions_bus_outlined,
    ),
    Layanan(
      nama: 'Pengaduan Jalan Rusak',
      bidang: 'Transportasi',
      deskripsi:
          'Layanan penyampaian laporan '
          'kerusakan jalan.',
      ikon: Icons.add_road,
    ),
    Layanan(
      nama: 'Informasi Parkir',
      bidang: 'Transportasi',
      deskripsi:
          'Informasi fasilitas dan '
          'ketentuan parkir umum.',
      ikon: Icons.local_parking,
    ),
  ];
}
