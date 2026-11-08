import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/favorit_cubit.dart';
import 'cubit/pengajuan_cubit.dart';
import 'cubit/theme_cubit.dart';

import 'models/layanan.dart';
import 'theme/app_theme.dart';

import 'pages/beranda_page.dart';
import 'pages/layanan_page.dart';
import 'pages/warga_page.dart';
import 'pages/detail_layanan_page.dart';

void main() {
  runApp(const NusantaraCerdasApp());
}

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritCubit>(create: (_) => FavoritCubit()),
        BlocProvider<PengajuanCubit>(create: (_) => PengajuanCubit()),
        BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Nusantara Cerdas Mobile',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: '/',
            routes: {'/': (context) => const HalamanUtama()},
            onGenerateRoute: (settings) {
              if (settings.name == '/detail') {
                final argumen = settings.arguments;

                if (argumen is Layanan) {
                  return MaterialPageRoute<bool>(
                    settings: settings,
                    builder: (context) {
                      return DetailLayananPage(layanan: argumen);
                    },
                  );
                }
              }

              return null;
            },
          );
        },
      ),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int indexTerpilih = 0;

  final List<String> judulHalaman = const ['Beranda', 'Layanan', 'Warga'];

  void pindahHalaman(int index) {
    setState(() {
      indexTerpilih = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final layarLebar = constraints.maxWidth >= 700;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Nusantara Cerdas - '
              '${judulHalaman[indexTerpilih]}',
            ),
          ),

          // NavigationDrawer pada panel samping
          drawer: NavigationDrawer(
            selectedIndex: indexTerpilih,
            onDestinationSelected: (index) {
              Navigator.pop(context);
              pindahHalaman(index);
            },
            children: const [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Menu Nusantara Cerdas',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Beranda'),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.miscellaneous_services),
                label: Text('Layanan'),
              ),
              NavigationDrawerDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Warga'),
              ),
            ],
          ),

          // Tampilan halaman aktif
          body: Row(
            children: [
              if (layarLebar) ...[
                NavigationRail(
                  selectedIndex: indexTerpilih,
                  onDestinationSelected: pindahHalaman,
                  labelType: NavigationRailLabelType.all,
                  backgroundColor: scheme.surfaceContainerLow,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.miscellaneous_services_outlined),
                      selectedIcon: Icon(Icons.miscellaneous_services),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: _BadgePengajuan(ikon: Icons.people_outline),
                      selectedIcon: _BadgePengajuan(ikon: Icons.people),
                      label: Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
              ],

              Expanded(
                child: IndexedStack(
                  index: indexTerpilih,
                  children: const [BerandaPage(), LayananPage(), WargaPage()],
                ),
              ),
            ],
          ),

          // NavigationBar untuk layar sempit
          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: indexTerpilih,
                  onDestinationSelected: pindahHalaman,
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.miscellaneous_services_outlined),
                      selectedIcon: Icon(Icons.miscellaneous_services),
                      label: 'Layanan',
                    ),
                    NavigationDestination(
                      icon: _BadgePengajuan(ikon: Icons.people_outline),
                      selectedIcon: _BadgePengajuan(ikon: Icons.people),
                      label: 'Warga',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

// Widget badge reaktif untuk jumlah pengajuan
class _BadgePengajuan extends StatelessWidget {
  final IconData ikon;

  const _BadgePengajuan({required this.ikon});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(ikon),
        );
      },
    );
  }
}
