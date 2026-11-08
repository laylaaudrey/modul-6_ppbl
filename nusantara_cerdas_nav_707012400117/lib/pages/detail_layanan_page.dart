
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/layanan.dart';
import '../cubit/pengajuan_cubit.dart';

class DetailLayananPage extends StatefulWidget {
  final Layanan layanan;

  const DetailLayananPage({
    super.key,
    required this.layanan,
  });

  @override
  State<DetailLayananPage> createState() =>
      _DetailLayananPageState();
}

class _DetailLayananPageState
    extends State<DetailLayananPage> {
  bool sedangMengirim = false;

  Future<void> _ajukanPermohonan() async {
    if (sedangMengirim) return;

    setState(() {
      sedangMengirim = true;
    });

    // Simulasi proses pengiriman
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (!mounted) return;

    context.read<PengajuanCubit>().tambah(
      widget.layanan.nama,
    );

    setState(() {
      sedangMengirim = false;
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final layanan = widget.layanan;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: scheme.primaryContainer,
              child: Icon(
                layanan.ikon,
                size: 48,
                color: scheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            layanan.nama,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Bidang ${layanan.bidang}',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                layanan.deskripsi,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: sedangMengirim
                ? null
                : _ajukanPermohonan,
            child: sedangMengirim
                ? const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('Sedang Mengirim...'),
                    ],
                  )
                : const Text('Ajukan Permohonan'),
          ),
        ],
      ),
    );
  }
}
