
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/laporan_cubit.dart';
import '../cubit/theme_cubit.dart';
import '../data/data_contoh.dart';
import '../models/laporan.dart';
import '../widgets/kartu_konten.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: scheme.primary,
                  child: Icon(
                    Icons.person,
                    size: 42,
                    color: scheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Akun Demo',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                ),
                Text(
                  'demo@mitigasiplus.id',
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        Text(
          'Pengaturan',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

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

        const SizedBox(height: 16),

        Text(
          'Informasi Favorit',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favorit) {
            final tersimpan = DataContoh.konten
                .where(
                  (item) => favorit.contains(item.id),
                )
                .toList();

            if (tersimpan.isEmpty) {
              return const Card(
                child: ListTile(
                  leading: Icon(
                    Icons.favorite_border,
                  ),
                  title: Text('Belum ada favorit'),
                  subtitle: Text(
                    'Ketuk ikon hati pada Berita '
                    'atau Edukasi.',
                  ),
                ),
              );
            }

            return Column(
              children: tersimpan.map((item) {
                return KartuKonten(konten: item);
              }).toList(),
            );
          },
        ),

        const SizedBox(height: 16),

        Text(
          'Aktivitas Saya',
          style: Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        BlocBuilder<LaporanCubit, List<Laporan>>(
          builder: (context, laporan) {
            final milikSaya = laporan
                .where((item) => item.laporanSaya)
                .toList();

            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.assignment_outlined,
                ),
                title: const Text(
                  'Laporan yang dibuat',
                ),
                subtitle: Text(
                  milikSaya.isEmpty
                      ? 'Belum membuat laporan'
                      : milikSaya
                          .map((e) => e.judul)
                          .join(' • '),
                ),
                trailing: Text(
                  '${milikSaya.length}',
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        Text(
          'Aplikasi demonstrasi: tidak ada login '
          'atau pengiriman laporan ke server.',
          style: Theme.of(context)
              .textTheme
              .bodySmall,
        ),
      ],
    );
  }
}
