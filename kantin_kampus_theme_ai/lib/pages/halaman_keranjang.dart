
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';
import '../cubit/keranjang_cubit.dart';
import '../widgets/cart_summary_bar.dart';
import '../widgets/theme_toggle_button.dart';

class HalamanKeranjang extends StatelessWidget {
  const HalamanKeranjang({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: const [
          // Tombol pengganti tema
          ThemeToggleButton(),
        ],
      ),

      body: BlocBuilder<
          KeranjangCubit,
          List<ItemKeranjang>>(
        builder: (context, daftarItem) {
          final keranjangCubit =
              context.read<KeranjangCubit>();

          // Tampilan ketika keranjang kosong
          if (daftarItem.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Keranjang masih kosong',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Silakan tambahkan produk '
                    'dari daftar menu.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(
                          color:
                              colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            );
          }

          // Tampilan ketika keranjang berisi produk
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: daftarItem.length,
                  itemBuilder: (context, index) {
                    final item = daftarItem[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            item.produk.nama,
                            style: theme.textTheme.titleMedium
                                ?.copyWith(
                                  color: colorScheme.onSurface,
                                ),
                          ),

                          subtitle: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                'Harga: Rp ${item.produk.harga}',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(
                                      color: colorScheme
                                          .onSurfaceVariant,
                                    ),
                              ),
                              Text(
                                'Subtotal: Rp ${item.subtotal}',
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),

                          // Tombol tambah dan kurangi
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Kurangi jumlah',
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: colorScheme.primary,
                                ),
                                onPressed: () {
                                  keranjangCubit.kurangi(
                                    item.produk,
                                  );
                                },
                              ),

                              Text(
                                '${item.jumlah}',
                                style: theme.textTheme.titleMedium,
                              ),

                              IconButton(
                                tooltip: 'Tambah jumlah',
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: colorScheme.primary,
                                ),
                                onPressed: () {
                                  keranjangCubit.tambah(
                                    item.produk,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Widget custom ringkasan keranjang
              CartSummaryBar(
                totalItem: keranjangCubit.totalItem,
                totalHarga: keranjangCubit.totalHarga,
                onKosongkan: () {
                  keranjangCubit.kosongkan();

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Keranjang berhasil dikosongkan',
                        ),
                      ),
                    );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
