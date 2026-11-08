
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final isDark = themeMode == ThemeMode.dark;

        return IconButton(
          tooltip: isDark
              ? 'Aktifkan tema terang'
              : 'Aktifkan tema gelap',
          icon: Icon(
            isDark
                ? Icons.light_mode
                : Icons.dark_mode,
            color: Theme.of(context)
                .colorScheme
                .onPrimary,
          ),
          onPressed: () {
            context.read<ThemeCubit>().toggle();
          },
        );
      },
    );
  }
}
