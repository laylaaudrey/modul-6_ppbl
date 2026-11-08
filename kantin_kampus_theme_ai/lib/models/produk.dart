
class Produk {
  final String id;
  final String nama;
  final int harga;

  const Produk({
    required this.id,
    required this.nama,
    required this.harga,
  });
}

class ItemKeranjang {
  final Produk produk;
  final int jumlah;

  const ItemKeranjang({
    required this.produk,
    required this.jumlah,
  });

  int get subtotal => produk.harga * jumlah;

  ItemKeranjang copyWith({
    Produk? produk,
    int? jumlah,
  }) {
    return ItemKeranjang(
      produk: produk ?? this.produk,
      jumlah: jumlah ?? this.jumlah,
    );
  }
}
