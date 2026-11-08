import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/laporan_cubit.dart';
import 'cubit/theme_cubit.dart';

import 'pages/beranda_page.dart';
import 'pages/berita_page.dart';
import 'pages/laporan_page.dart';
import 'pages/edukasi_page.dart';
import 'pages/profil_page.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MitigasiPlusApp());
}

class MitigasiPlusApp extends StatelessWidget {
  const MitigasiPlusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(create: (_) => FavoritCubit()),
        BlocProvider<LaporanCubit>(create: (_) => LaporanCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) {
          return MaterialApp(
            title: 'MitigasiPlus',
            debugShowCheckedModeBanner: false,

            // Tema terang dan gelap
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: mode,

            home: const HalamanUtama(),
          );
        },
      ),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() {
    return _HalamanUtamaState();
  }
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int halamanAktif = 0;

  static const judul = [
    'Beranda',
    'Berita',
    'Laporan Masyarakat',
    'Edukasi Bencana',
    'Profil Saya',
  ];

  static const ikon = [
    Icons.home_outlined,
    Icons.newspaper_outlined,
    Icons.assignment_outlined,
    Icons.school_outlined,
    Icons.person_outline,
  ];

  static const ikonAktif = [
    Icons.home,
    Icons.newspaper,
    Icons.assignment,
    Icons.school,
    Icons.person,
  ];

  static const nama = ['Beranda', 'Berita', 'Laporan', 'Edukasi', 'Profil'];

  void pindah(int index) {
    setState(() {
      halamanAktif = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lebar = MediaQuery.sizeOf(context).width;

    // Navigasi adaptif
    final pakaiRail = lebar >= 720;

    final halaman = [
      BerandaPage(pindahTab: pindah),
      const BeritaPage(),
      const LaporanPage(),
      const EdukasiPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('MitigasiPlus • ${judul[halamanAktif]}')),

      // Menu samping
      drawer: NavigationDrawer(
        selectedIndex: halamanAktif,
        onDestinationSelected: (index) {
          Navigator.of(context).pop();
          pindah(index);
        },
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Menu MitigasiPlus',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),

          for (var i = 0; i < nama.length; i++)
            NavigationDrawerDestination(
              icon: Icon(ikon[i]),
              selectedIcon: Icon(ikonAktif[i]),
              label: Text(nama[i]),
            ),
        ],
      ),

      body: Row(
        children: [
          // NavigationRail untuk layar lebar
          if (pakaiRail) ...[
            NavigationRail(
              selectedIndex: halamanAktif,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: pindah,
              destinations: [
                for (var i = 0; i < nama.length; i++)
                  NavigationRailDestination(
                    icon: Icon(ikon[i]),
                    selectedIcon: Icon(ikonAktif[i]),
                    label: Text(nama[i]),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
          ],

          // Konten halaman aktif
          Expanded(
            child: IndexedStack(index: halamanAktif, children: halaman),
          ),
        ],
      ),

      // NavigationBar untuk layar HP
      bottomNavigationBar: pakaiRail
          ? null
          : NavigationBar(
              selectedIndex: halamanAktif,
              onDestinationSelected: pindah,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              destinations: [
                for (var i = 0; i < nama.length; i++)
                  NavigationDestination(
                    icon: Icon(ikon[i]),
                    selectedIcon: Icon(ikonAktif[i]),
                    label: nama[i],
                  ),
              ],
            ),
    );
  }
}
