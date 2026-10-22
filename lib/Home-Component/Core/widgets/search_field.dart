import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hint;
  const AppSearchField({super.key, this.onChanged, this.hint = 'Search products or SKU…'});

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: c),
        );
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.muted),
        prefixIcon: const Icon(Icons.search, color: AppColors.muted),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: b(AppColors.border),
        enabledBorder: b(AppColors.border),
        focusedBorder: b(AppColors.sidebar),
      ),
    );
  }
}