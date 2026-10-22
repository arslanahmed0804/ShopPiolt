import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class AuthSubmitButton extends StatelessWidget {
  final String label;
  final bool busy;
  final VoidCallback onPressed;
  const AuthSubmitButton({super.key, required this.label, required this.busy, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: busy ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.dark,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      child: busy
          ? const SizedBox(
              width: 22, height: 22,
              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
          : Text(label, style: const TextStyle(fontSize: 17)),
    );
  }
}