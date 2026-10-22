import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';

class CategoryDropdown extends StatelessWidget {
  final List<String> categories;
  final String? value; // null = All
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.muted),
          style: const TextStyle(color: AppColors.ink, fontSize: 16),
          items: [
            const DropdownMenuItem<String?>(value: null, child: Text('All categories')),
            for (final c in categories) DropdownMenuItem<String?>(value: c, child: Text(c)),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}