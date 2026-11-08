
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/laporan_cubit.dart';
import '../models/laporan.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaporanCubit, List<Laporan>>(
      builder: (context, daftar) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Laporan Masyarakat',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            const SizedBox(height: 6),
            Text(
              'Contoh laporan warga. Belum terhubung '
              'dengan pusat komando.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            ),
            const SizedBox(height: 12),

            FilledButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Tambah Laporan'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) =>
                        const FormLaporanPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ...daftar.map((laporan) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              laporan.judul,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          ),
                          if (laporan.laporanSaya)
                            const Chip(
                              label: Text('Laporan Saya'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        laporan.deskripsi,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 17,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(laporan.lokasi),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${laporan.kategori} • '
                        '${_tanggal(laporan.waktu)}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  static String _tanggal(DateTime waktu) {
    final hari = waktu.day
        .toString()
        .padLeft(2, '0');
    final bulan = waktu.month
        .toString()
        .padLeft(2, '0');

    return '$hari/$bulan/${waktu.year}';
  }
}

class FormLaporanPage extends StatefulWidget {
  const FormLaporanPage({super.key});

  @override
  State<FormLaporanPage> createState() {
    return _FormLaporanPageState();
  }
}

class _FormLaporanPageState
    extends State<FormLaporanPage> {
  final formKey = GlobalKey<FormState>();

  final judulController = TextEditingController();
  final lokasiController = TextEditingController();
  final deskripsiController = TextEditingController();

  String kategori = 'Banjir';
  bool sedangMengirim = false;

  @override
  void dispose() {
    judulController.dispose();
    lokasiController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  Future<void> kirim() async {
    if (sedangMengirim ||
        !(formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      sedangMengirim = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 800),
    );

    if (!mounted) return;

    final sekarang = DateTime.now();

    context.read<LaporanCubit>().tambah(
          Laporan(
            id: sekarang
                .microsecondsSinceEpoch
                .toString(),
            judul: judulController.text.trim(),
            lokasi: lokasiController.text.trim(),
            deskripsi:
                deskripsiController.text.trim(),
            kategori: kategori,
            waktu: sekarang,
            laporanSaya: true,
          ),
        );

    final messenger = ScaffoldMessenger.of(context);

    Navigator.pop(context);

    messenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Laporan tersimpan di aplikasi (simulasi).',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Laporan'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Laporkan kondisi di sekitar Anda',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: judulController,
              decoration: const InputDecoration(
                labelText: 'Judul laporan',
              ),
              validator: (v) {
                return (v?.trim().isEmpty ?? true)
                    ? 'Judul wajib diisi'
                    : null;
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori bencana',
              ),
              items: const [
                'Banjir',
                'Gempa Bumi',
                'Longsor',
                'Cuaca Ekstrem',
                'Kebakaran',
                'Lainnya',
              ].map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: sedangMengirim
                  ? null
                  : (v) {
                      setState(() {
                        kategori = v ?? kategori;
                      });
                    },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: lokasiController,
              decoration: const InputDecoration(
                labelText: 'Lokasi kejadian',
              ),
              validator: (v) {
                return (v?.trim().isEmpty ?? true)
                    ? 'Lokasi wajib diisi'
                    : null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: deskripsiController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Deskripsi kejadian',
              ),
              validator: (v) {
                return (v?.trim().isEmpty ?? true)
                    ? 'Deskripsi wajib diisi'
                    : null;
              },
            ),

            const SizedBox(height: 16),

            Text(
              'Jangan mendekati lokasi berbahaya '
              'hanya untuk membuat laporan.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            ),

            const SizedBox(height: 20),

            FilledButton.icon(
              onPressed: sedangMengirim ? null : kirim,
              icon: sedangMengirim
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send_outlined),
              label: Text(
                sedangMengirim
                    ? 'Menyimpan...'
                    : 'Kirim Laporan',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
