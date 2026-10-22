import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/Data/models/product.dart';
import '../Core/widgets/section_card.dart';
import 'low_stock_row.dart';

class LowStockCard extends StatelessWidget {
  final List<Product> products;
  final ValueChanged<Product> onRestock;
  final VoidCallback onViewAll;

  const LowStockCard({
    super.key,
    required this.products,
    required this.onRestock,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Low stock',
      subtitle: 'Products below their minimum quantity',
      actionLabel: 'View all',
      onAction: onViewAll,
      child: Column(children: [
        for (var i = 0; i < products.length; i++) ...[
          LowStockRow(product: products[i], onRestock: () => onRestock(products[i])),
          if (i != products.length - 1) const Divider(height: 1, color: AppColors.border),
        ],
      ]),
    );
  }
}