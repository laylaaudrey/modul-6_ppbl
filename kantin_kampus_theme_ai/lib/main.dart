
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/keranjang_cubit.dart';
import 'cubit/theme_cubit.dart';
import 'pages/halaman_produk.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const KantinKampusApp());
}

class KantinKampusApp extends StatelessWidget {
  const KantinKampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeranjangCubit>(
          create: (context) => KeranjangCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Kantin Kampus',
            debugShowCheckedModeBanner: false,

            // Tema terpusat
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,

            // Mengikuti state ThemeCubit
            themeMode: themeMode,

            home: const HalamanProduk(),
          );
        },
      ),
    );
  }
}
