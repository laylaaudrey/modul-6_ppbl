
import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          color: scheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_city,
                  size: 55,
                  color: scheme.onPrimaryContainer,
                ),
                const SizedBox(height: 16),
                Text(
                  'Selamat Datang!',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nusantara Cerdas Mobile',
                  style: theme.textTheme.titleLarge
                      ?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Akses berbagai layanan publik '
                  'dengan lebih mudah, cepat, '
                  'dan terintegrasi.',
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(
                    color: scheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Bidang Layanan',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        const _KartuBidang(
          ikon: Icons.description_outlined,
          judul: 'Perizinan',
          deskripsi:
              'Layanan administrasi dan perizinan.',
        ),
        const _KartuBidang(
          ikon: Icons.local_hospital_outlined,
          judul: 'Kesehatan',
          deskripsi:
              'Informasi dan pelayanan kesehatan.',
        ),
        const _KartuBidang(
          ikon: Icons.directions_bus_outlined,
          judul: 'Transportasi',
          deskripsi:
              'Informasi transportasi dan jalan.',
        ),
      ],
    );
  }
}

class _KartuBidang extends StatelessWidget {
  final IconData ikon;
  final String judul;
  final String deskripsi;

  const _KartuBidang({
    required this.ikon,
    required this.judul,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Icon(
            ikon,
            color: scheme.onPrimaryContainer,
          ),
        ),
        title: Text(
          judul,
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(deskripsi),
      ),
    );
  }
}
