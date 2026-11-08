
import 'package:flutter/material.dart';

import 'primary_button.dart';

class CartSummaryBar extends StatelessWidget {
  final int totalItem;
  final int totalHarga;
  final VoidCallback onKosongkan;

  const CartSummaryBar({
    super.key,
    required this.totalItem,
    required this.totalHarga,
    required this.onKosongkan,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant,
          ),
        ),
      ),

      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Item',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),

                Text(
                  '$totalItem',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),

                Text(
                  'Rp $totalHarga',
                  style: textTheme.titleLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            PrimaryButton(
              label: 'Kosongkan Keranjang',
              icon: Icons.delete_outline,
              onPressed: onKosongkan,
            ),
          ],
        ),
      ),
    );
  }
}
