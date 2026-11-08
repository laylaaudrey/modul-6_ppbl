
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../cubit/theme_cubit.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Layanan Warga',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 20),

        // Bagian layanan favorit
        Text(
          'Layanan Favorit',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final daftarFavorit = DataLayanan.semua
                .where(
                  (layanan) =>
                      favorit.contains(layanan.nama),
                )
                .toList();

            if (daftarFavorit.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(Icons.star_border),
                  title: Text('Belum ada favorit'),
                  subtitle: Text(
                    'Tandai layanan melalui '
                    'halaman Layanan.',
                  ),
                ),
              );
            }

            return Column(
              children: daftarFavorit.map((layanan) {
                return Card(
                  child: ListTile(
                    leading: Icon(layanan.ikon),
                    title: Text(layanan.nama),
                    subtitle: Text(layanan.bidang),
                    trailing: IconButton(
                      tooltip: 'Hapus favorit',
                      icon: const Icon(Icons.star),
                      onPressed: () {
                        context
                            .read<FavoritCubit>()
                            .batalTandai(layanan.nama);
                      },
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: layanan,
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 24),

        // Bagian keranjang pengajuan
        Text(
          'Keranjang Pengajuan',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),

        BlocBuilder<PengajuanCubit, List<String>>(
          builder: (context, pengajuan) {
            if (pengajuan.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.inbox_outlined,
                  ),
                  title: Text(
                    'Belum ada pengajuan',
                  ),
                  subtitle: Text(
                    'Pilih layanan dan tekan '
                    'Ajukan Permohonan.',
                  ),
                ),
              );
            }

            return Column(
              children: [
                ...pengajuan.map((nama) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.assignment_outlined,
                      ),
                      title: Text(nama),
                      trailing: IconButton(
                        tooltip: 'Hapus pengajuan',
                        icon: const Icon(
                          Icons.delete_outline,
                        ),
                        onPressed: () {
                          context
                              .read<PengajuanCubit>()
                              .hapus(nama);
                        },
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: Text(
                      'Kirim Semua '
                      '(${pengajuan.length})',
                    ),
                    onPressed: () {
                      final jumlah = context
                          .read<PengajuanCubit>()
                          .kirimSemua();

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            '$jumlah layanan berhasil '
                            'diproses (simulasi).',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 24),

        // Pengaturan mode aplikasi
        Text(
          'Pengaturan Tampilan',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),

        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) {
            return Card(
              child: SwitchListTile(
                secondary: Icon(
                  mode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: const Text('Mode Gelap'),
                subtitle: const Text(
                  'Ubah tampilan terang atau gelap',
                ),
                value: mode == ThemeMode.dark,
                onChanged: (_) {
                  context.read<ThemeCubit>().toggle();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
