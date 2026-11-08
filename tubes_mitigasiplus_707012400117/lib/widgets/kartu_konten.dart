
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../models/konten.dart';

class KartuKonten extends StatelessWidget {
  final Konten konten;

  const KartuKonten({
    super.key,
    required this.konten,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _bukaDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: scheme.primaryContainer,
                    child: Icon(
                      konten.ikon,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      konten.kategori,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                            color: scheme.primary,
                          ),
                    ),
                  ),
                  BlocSelector<
                      FavoritCubit,
                      Set<String>,
                      bool>(
                    selector: (state) {
                      return state.contains(konten.id);
                    },
                    builder: (context, favorit) {
                      return IconButton(
                        tooltip: favorit
                            ? 'Hapus dari favorit'
                            : 'Simpan favorit',
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .toggle(konten.id);
                        },
                        icon: Icon(
                          favorit
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorit
                              ? scheme.error
                              : scheme.onSurfaceVariant,
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                konten.judul,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                konten.ringkasan,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Baca selengkapnya',
                style: TextStyle(
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bukaDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailKontenPage(
          konten: konten,
        ),
      ),
    );
  }
}

class DetailKontenPage extends StatelessWidget {
  final Konten konten;

  const DetailKontenPage({
    super.key,
    required this.konten,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Bencana'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Icon(
            konten.ikon,
            size: 70,
            color: scheme.primary,
          ),
          const SizedBox(height: 18),
          Text(
            konten.kategori,
            style: TextStyle(
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            konten.judul,
            style: Theme.of(context)
                .textTheme
                .headlineSmall,
          ),
          const SizedBox(height: 20),
          Text(
            konten.isi,
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
          ),
          const SizedBox(height: 24),
          BlocSelector<
              FavoritCubit,
              Set<String>,
              bool>(
            selector: (state) {
              return state.contains(konten.id);
            },
            builder: (context, favorit) {
              return OutlinedButton.icon(
                onPressed: () {
                  context
                      .read<FavoritCubit>()
                      .toggle(konten.id);
                },
                icon: Icon(
                  favorit
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: Text(
                  favorit
                      ? 'Hapus Favorit'
                      : 'Simpan ke Favorit',
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
