
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/favorit_cubit.dart';

class LayananPage extends StatelessWidget {
  const LayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.description_outlined),
                text: 'Perizinan',
              ),
              Tab(
                icon: Icon(Icons.local_hospital_outlined),
                text: 'Kesehatan',
              ),
              Tab(
                icon: Icon(Icons.directions_bus_outlined),
                text: 'Transportasi',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _DaftarLayanan(bidang: 'Perizinan'),
                _DaftarLayanan(bidang: 'Kesehatan'),
                _DaftarLayanan(bidang: 'Transportasi'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DaftarLayanan extends StatelessWidget {
  final String bidang;

  const _DaftarLayanan({
    required this.bidang,
  });

  @override
  Widget build(BuildContext context) {
    final daftar = DataLayanan.semua
        .where((layanan) => layanan.bidang == bidang)
        .toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: daftar.length,
      itemBuilder: (context, index) {
        return KartuLayanan(
          layanan: daftar[index],
        );
      },
    );
  }
}

class KartuLayanan extends StatelessWidget {
  final Layanan layanan;

  const KartuLayanan({
    super.key,
    required this.layanan,
  });

  Future<void> _bukaDetail(BuildContext context) async {
    final hasil = await Navigator.pushNamed<bool>(
      context,
      '/detail',
      arguments: layanan,
    );

    if (!context.mounted) return;

    if (hasil == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Layanan masuk ke keranjang pengajuan.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                layanan.ikon,
                color: scheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    layanan.nama,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    layanan.bidang,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _bukaDetail(context),
                    child: const Text('Lihat Detail'),
                  ),
                ],
              ),
            ),
            BlocSelector<
                FavoritCubit,
                Set<String>,
                bool>(
              selector: (state) {
                return state.contains(layanan.nama);
              },
              builder: (context, isFavorit) {
                return IconButton(
                  tooltip: isFavorit
                      ? 'Batalkan favorit'
                      : 'Tandai favorit',
                  icon: Icon(
                    isFavorit
                        ? Icons.star
                        : Icons.star_border,
                    color: isFavorit
                        ? scheme.tertiary
                        : scheme.onSurfaceVariant,
                  ),
                  onPressed: () {
                    final cubit =
                        context.read<FavoritCubit>();

                    if (isFavorit) {
                      cubit.batalTandai(layanan.nama);
                    } else {
                      cubit.tandai(layanan.nama);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
