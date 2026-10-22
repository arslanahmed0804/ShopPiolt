import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
// import '../../Home-Component/Core/theme/app_colors.dart';
import '../../../Home-Component/Core/theme/app_colors.dart';

class ProductsHeader extends StatelessWidget {
  final int count;
  final VoidCallback onAddProduct;
  const ProductsHeader({super.key, required this.count, required this.onAddProduct});

  @override
  Widget build(BuildContext context) {
    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('CATALOG',
          style: TextStyle(color: AppColors.muted, letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 14)),
      const SizedBox(height: 6),
      const Text('Products',
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, height: 1.1, letterSpacing: -1)),
      const SizedBox(height: 10),
      Text('$count products in your catalog.',
          style: const TextStyle(color: AppColors.muted, fontSize: 17)),
    ]);
    final button = FilledButton.icon(
      onPressed: onAddProduct,
      icon: const Icon(Icons.add),
      label: const Text('Add product', style: TextStyle(fontSize: 16)),
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.dark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth < 600) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text,
          const SizedBox(height: 16),
          button,
        ]);
      }
      return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Expanded(child: text), button]);
    });
  }
}