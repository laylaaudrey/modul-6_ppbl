
import 'package:flutter/material.dart';
import '../models/konten.dart';
import '../models/laporan.dart';

class DataContoh {
  static const konten = <Konten>[
    Konten(
      id: 'b1',
      judul: 'Waspada Hujan Lebat di Wilayah Perbukitan',
      kategori: 'Cuaca Ekstrem',
      jenis: JenisKonten.berita,
      ringkasan:
          'Kenali tanda-tanda risiko longsor saat hujan '
          'berlangsung lama.',
      isi:
          'Hujan deras yang berlangsung lama dapat '
          'meningkatkan risiko tanah longsor, terutama '
          'di lereng curam. Hindari berada di bawah '
          'tebing dan perhatikan retakan tanah atau '
          'perubahan aliran air. Informasi ini merupakan '
          'contoh konten edukatif, bukan peringatan '
          'cuaca terkini.',
      ikon: Icons.thunderstorm_outlined,
    ),
    Konten(
      id: 'b2',
      judul: 'Pentingnya Jalur Evakuasi Lingkungan',
      kategori: 'Kesiapsiagaan',
      jenis: JenisKonten.berita,
      ringkasan:
          'Warga dianjurkan mengenali titik kumpul '
          'dan rute evakuasi.',
      isi:
          'Kenali jalur keluar dari rumah, sekolah, '
          'dan tempat kerja. Tentukan titik kumpul '
          'di ruang terbuka yang aman dan sepakati '
          'cara menghubungi keluarga saat komunikasi '
          'terganggu. Ini adalah artikel contoh.',
      ikon: Icons.route_outlined,
    ),
    Konten(
      id: 'b3',
      judul: 'Kenali Informasi Resmi Saat Bencana',
      kategori: 'Informasi',
      jenis: JenisKonten.berita,
      ringkasan:
          'Periksa sumber informasi sebelum '
          'menyebarkan kabar darurat.',
      isi:
          'Pastikan informasi berasal dari BPBD, '
          'BMKG, BNPB atau instansi setempat yang '
          'berwenang. Hindari menyebarkan lokasi '
          'dan angka korban yang belum terverifikasi. '
          'Artikel ini adalah data contoh.',
      ikon: Icons.campaign_outlined,
    ),
    Konten(
      id: 'e1',
      judul: 'Langkah Aman Saat Gempa Bumi',
      kategori: 'Gempa Bumi',
      jenis: JenisKonten.edukasi,
      ringkasan:
          'Merunduk, berlindung, dan berpegangan '
          'hingga guncangan berhenti.',
      isi:
          'Saat guncangan, merunduk, berlindung '
          'di bawah meja yang kokoh, dan berpegangan. '
          'Jauhi kaca dan benda yang dapat jatuh. '
          'Setelah guncangan berhenti, keluar '
          'melalui tangga jika aman. Di wilayah '
          'pesisir, segera ikuti arahan evakuasi '
          'tsunami dari otoritas.',
      ikon: Icons.vibration_outlined,
    ),
    Konten(
      id: 'e2',
      judul: 'Pertolongan Pertama pada Luka Ringan',
      kategori: 'Pertolongan Pertama',
      jenis: JenisKonten.edukasi,
      ringkasan:
          'Lakukan pertolongan sederhana sambil '
          'memperhatikan keselamatan.',
      isi:
          'Pastikan lokasi aman. Cuci tangan bila '
          'memungkinkan, tekan perdarahan ringan '
          'dengan kain bersih, bilas luka menggunakan '
          'air bersih dan tutup dengan perban steril. '
          'Untuk perdarahan berat, korban tidak sadar, '
          'atau cedera serius, segera hubungi '
          'layanan darurat setempat.',
      ikon: Icons.medical_services_outlined,
    ),
    Konten(
      id: 'e3',
      judul: 'Persiapan Tas Siaga Bencana',
      kategori: 'Kesiapsiagaan',
      jenis: JenisKonten.edukasi,
      ringkasan:
          'Siapkan dokumen, obat pribadi, air, '
          'senter, dan perlengkapan penting.',
      isi:
          'Siapkan tas yang mudah dibawa berisi '
          'salinan dokumen penting, air minum, '
          'makanan tahan lama, senter, peluit, '
          'baterai cadangan, obat pribadi, '
          'perlengkapan sanitasi, dan pakaian '
          'secukupnya. Periksa secara berkala '
          'masa kedaluwarsanya.',
      ikon: Icons.backpack_outlined,
    ),
    Konten(
      id: 'e4',
      judul: 'Menghadapi Banjir dengan Aman',
      kategori: 'Banjir',
      jenis: JenisKonten.edukasi,
      ringkasan:
          'Hindari arus air, jaringan listrik, '
          'dan jalan yang tergenang.',
      isi:
          'Ikuti arahan petugas. Matikan listrik '
          'bila dapat dilakukan dengan aman. '
          'Jangan melintasi arus banjir dengan '
          'berjalan kaki atau kendaraan. Bergerak '
          'ke lokasi lebih tinggi dan bantu '
          'anggota keluarga yang memerlukan '
          'pendampingan.',
      ikon: Icons.water_outlined,
    ),
  ];

  static final laporanAwal = <Laporan>[
    Laporan(
      id: 'l1',
      judul: 'Genangan Air di Jalan Utama',
      lokasi: 'Palu Barat',
      deskripsi:
          'Genangan menghambat akses jalan.',
      kategori: 'Banjir',
      waktu: DateTime(2026, 11, 7, 9, 30),
    ),
    Laporan(
      id: 'l2',
      judul: 'Pohon Tumbang Akibat Angin',
      lokasi: 'Palu Timur',
      deskripsi:
          'Pohon menghalangi sebagian ruas jalan.',
      kategori: 'Cuaca Ekstrem',
      waktu: DateTime(2026, 11, 6, 15, 20),
    ),
  ];
}
