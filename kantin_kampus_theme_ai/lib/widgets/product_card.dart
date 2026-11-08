  
import 'package:flutter/material.dart';

import '../models/produk.dart';

class ProductCard extends StatelessWidget {
  final Produk produk;
  final VoidCallback onTambah;

  const ProductCard({
    super.key,
    required this.produk,
    required this.onTambah,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor:
                  colorScheme.primaryContainer,
              child: Icon(
                Icons.fastfood,
                color: colorScheme.onPrimaryContainer,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    produk.nama,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Rp ${produk.harga}',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              tooltip: 'Tambah ${produk.nama}',
              onPressed: onTambah,
              icon: Icon(
                Icons.add_circle,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
