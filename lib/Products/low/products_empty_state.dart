import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/widgets/app_card.dart';
import '../../Home-Component/Core/widgets/app_card.dart';

class ProductsEmptyState extends StatelessWidget {
  final VoidCallback onClear;
  const ProductsEmptyState({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.search_off, size: 40, color: AppColors.muted),
          const SizedBox(height: 14),
          const Text('No products found', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          const Text('Try a different search or clear your filters.',
              style: TextStyle(color: AppColors.muted, fontSize: 15)),
          const SizedBox(height: 20),
          OutlinedButton(onPressed: onClear, child: const Text('Clear filters')),
        ]),
      ),
    );
  }
}