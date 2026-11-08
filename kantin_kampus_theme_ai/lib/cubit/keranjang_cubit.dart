
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/produk.dart';

class KeranjangCubit extends Cubit<List<ItemKeranjang>> {
  KeranjangCubit() : super(const []);

  void tambah(Produk produk) {
    final daftarBaru = List<ItemKeranjang>.from(state);

    final index = daftarBaru.indexWhere(
      (item) => item.produk.id == produk.id,
    );

    if (index >= 0) {
      final itemLama = daftarBaru[index];

      daftarBaru[index] = itemLama.copyWith(
        jumlah: itemLama.jumlah + 1,
      );
    } else {
      daftarBaru.add(
        ItemKeranjang(
          produk: produk,
          jumlah: 1,
        ),
      );
    }

    emit(List.unmodifiable(daftarBaru));
  }

  void kurangi(Produk produk) {
    final daftarBaru = List<ItemKeranjang>.from(state);

    final index = daftarBaru.indexWhere(
      (item) => item.produk.id == produk.id,
    );

    if (index == -1) return;

    final itemLama = daftarBaru[index];

    if (itemLama.jumlah > 1) {
      daftarBaru[index] = itemLama.copyWith(
        jumlah: itemLama.jumlah - 1,
      );
    } else {
      daftarBaru.removeAt(index);
    }

    emit(List.unmodifiable(daftarBaru));
  }

  void kosongkan() {
    emit(const []);
  }

  int get totalHarga {
    return state.fold<int>(
      0,
      (total, item) => total + item.subtotal,
    );
  }

  int get totalItem {
    return state.fold<int>(
      0,
      (total, item) => total + item.jumlah,
    );
  }
}
