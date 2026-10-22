import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/widgets/app_card.dart';
import '../../Home-Component/Core/widgets/app_card.dart';
// import '../../Data/models/product.dart';
import '../../Home-Component/Core/Data/models/product.dart';
import 'product_table_row.dart';

/// Wide screens ke liye table. [footer] mein pagination aati hai.
class ProductsTable extends StatelessWidget {
  final List<Product> products;
  final Widget footer;
  final ValueChanged<Product> onRestock;
  final ValueChanged<Product> onDelete;

  const ProductsTable({
    super.key,
    required this.products,
    required this.footer,
    required this.onRestock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(children: [
        const _HeaderRow(),
        const Divider(height: 1, color: AppColors.border),
        for (final p in products) ...[
          ProductTableRow(product: p, onRestock: () => onRestock(p), onDelete: () => onDelete(p)),
          const Divider(height: 1, color: AppColors.border),
        ],
        footer,
      ]),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
        color: AppColors.muted, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.4);
    const labels = ['PRODUCT', 'CATEGORY', 'STOCK', 'PRICE', 'STATUS'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        for (var i = 0; i < labels.length; i++)
          Expanded(flex: kProductColumnFlex[i], child: Text(labels[i], style: style)),
        const SizedBox(width: kProductMenuWidth),
      ]),
    );
  }
}