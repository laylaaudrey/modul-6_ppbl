
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      textStyle: textTheme.labelLarge,
    );

    if (icon != null) {
      return ElevatedButton.icon(
        onPressed: onPressed,
        style: buttonStyle,
        icon: Icon(icon),
        label: Text(label),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(label),
    );
  }
}
