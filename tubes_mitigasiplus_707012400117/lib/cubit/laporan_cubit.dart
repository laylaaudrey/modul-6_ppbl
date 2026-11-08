
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_contoh.dart';
import '../models/laporan.dart';

class LaporanCubit extends Cubit<List<Laporan>> {
  LaporanCubit()
      : super(List.unmodifiable(DataContoh.laporanAwal));

  void tambah(Laporan laporan) {
    emit(
      List.unmodifiable([laporan, ...state]),
    );
  }

  int get totalLaporanSaya {
    return state
        .where((item) => item.laporanSaya)
        .length;
  }
}
