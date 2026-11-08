import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/produk.dart';
import '../cubit/keranjang_cubit.dart';
import '../widgets/product_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'halaman_keranjang.dart';

class HalamanProduk extends StatelessWidget {
  const HalamanProduk({super.key});

  // Data produk kantin sementara
  static const List<Produk> daftarProduk = [
    Produk(id: 'P001', nama: 'Nasi Goreng', harga: 15000),
    Produk(id: 'P002', nama: 'Mie Ayam', harga: 12000),
    Produk(id: 'P003', nama: 'Bakso', harga: 13000),
    Produk(id: 'P004', nama: 'Es Teh', harga: 5000),
    Produk(id: 'P005', nama: 'Kopi', harga: 7000),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kantin Kampus'),
        actions: [
          // Tombol untuk mengganti tema
          const ThemeToggleButton(),

          // Tombol keranjang dengan jumlah item
          BlocBuilder<KeranjangCubit, List<ItemKeranjang>>(
            builder: (context, state) {
              final totalItem = context.read<KeranjangCubit>().totalItem;

              return IconButton(
                tooltip: 'Keranjang ($totalItem item)',
                icon: Badge(
                  isLabelVisible: totalItem > 0,
                  label: Text('$totalItem'),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HalamanKeranjang(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      // Daftar produk
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Daftar Menu Kantin',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: daftarProduk.length,
              itemBuilder: (context, index) {
                final produk = daftarProduk[index];

                return ProductCard(
                  produk: produk,
                  onTambah: () {
                    // Menambahkan produk melalui Cubit
                    context.read<KeranjangCubit>().tambah(produk);

                    // Menampilkan notifikasi
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            '${produk.nama} ditambahkan '
                            'ke keranjang',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
