
class Laporan {
  final String id;
  final String judul;
  final String lokasi;
  final String deskripsi;
  final String kategori;
  final DateTime waktu;
  final bool laporanSaya;

  const Laporan({
    required this.id,
    required this.judul,
    required this.lokasi,
    required this.deskripsi,
    required this.kategori,
    required this.waktu,
    this.laporanSaya = false,
  });
}
