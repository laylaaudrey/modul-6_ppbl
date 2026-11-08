
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(const <String>[]);

  void tambah(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      return;
    }

    final daftarBaru = List<String>.from(state);
    daftarBaru.add(namaLayanan);

    emit(List.unmodifiable(daftarBaru));
  }

  void hapus(String namaLayanan) {
    final daftarBaru = List<String>.from(state);
    daftarBaru.remove(namaLayanan);

    emit(List.unmodifiable(daftarBaru));
  }

  void kosongkan() {
    emit(const <String>[]);
  }

  int kirimSemua() {
    final jumlah = totalPengajuan;
    kosongkan();
    return jumlah;
  }

  int get totalPengajuan => state.length;

  bool sudahDiajukan(String namaLayanan) {
    return state.contains(namaLayanan);
  }
}
