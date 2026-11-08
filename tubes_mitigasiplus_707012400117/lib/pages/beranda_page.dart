
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/laporan_cubit.dart';
import '../models/laporan.dart';

class BerandaPage extends StatelessWidget {
  final ValueChanged<int> pindahTab;

  const BerandaPage({
    super.key,
    required this.pindahTab,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Selamat Datang di MitigasiPlus',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          'Apa yang ingin Anda lakukan hari ini?',
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 22),

        Card(
          color: scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cloud_outlined,
                      color: scheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Kesiapsiagaan Bencana',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(
                            color: scheme.onPrimaryContainer,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Kenali risiko, siapkan rencana, '
                  'bantu sesama.',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Informasi di aplikasi ini bersifat '
                  'edukatif dan contoh; bukan peringatan '
                  'darurat real-time.',
                  style: theme.textTheme.bodySmall
                      ?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),
        Text(
          'Akses Cepat',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 8),

        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount:
              MediaQuery.sizeOf(context).width < 420
                  ? 2
                  : 4,
          childAspectRatio: 1.45,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            _Aksi(
              icon: Icons.newspaper_outlined,
              label: 'Berita',
              onTap: () => pindahTab(1),
            ),
            _Aksi(
              icon: Icons.report_outlined,
              label: 'Lapor Kondisi',
              onTap: () => pindahTab(2),
            ),
            _Aksi(
              icon: Icons.school_outlined,
              label: 'Edukasi',
              onTap: () => pindahTab(3),
            ),
            _Aksi(
              icon: Icons.person_outline,
              label: 'Profil',
              onTap: () => pindahTab(4),
            ),
          ],
        ),

        const SizedBox(height: 22),
        Text(
          'Ringkasan Aktivitas',
          style: theme.textTheme.titleLarge,
        ),

        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, state) {
            return ListTile(
              leading: const Icon(
                Icons.favorite_outline,
              ),
              title: const Text('Informasi favorit'),
              trailing: Text(
                '${state.length} tersimpan',
              ),
              onTap: () => pindahTab(4),
            );
          },
        ),

        BlocBuilder<LaporanCubit, List<Laporan>>(
          builder: (context, state) {
            return ListTile(
              leading: const Icon(
                Icons.assignment_outlined,
              ),
              title: const Text('Laporan saya'),
              trailing: Text(
                '${context.read<LaporanCubit>().totalLaporanSaya} laporan',
              ),
              onTap: () => pindahTab(2),
            );
          },
        ),

        const SizedBox(height: 10),
        FilledButton.tonalIcon(
          onPressed: () => _panduanDarurat(context),
          icon: const Icon(
            Icons.health_and_safety_outlined,
          ),
          label: const Text('Panduan Saat Darurat'),
        ),
      ],
    );
  }

  void _panduanDarurat(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Saat kondisi darurat'),
          content: const Text(
            'Pastikan diri aman, ikuti arahan petugas, '
            'dan hubungi layanan darurat resmi setempat. '
            'Jangan memasuki area berbahaya demi mengambil '
            'gambar atau membuat laporan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Mengerti'),
            ),
          ],
        );
      },
    );
  }
}

class _Aksi extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _Aksi({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 30,
              color: scheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
