import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/widgets/app_card.dart';
import '../../Home-Component/Core/widgets/app_card.dart';
// import '../../Data/models/product.dart';
import '../../Home-Component/Core/Data/models/product.dart';
import 'product_list_tile.dart';

/// Mobile layout: table ki jagah list.
class ProductsList extends StatelessWidget {
  final List<Product> products;
  final Widget footer;
  final ValueChanged<Product> onRestock;
  final ValueChanged<Product> onDelete;

  const ProductsList({
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
        for (final p in products) ...[
          ProductListTile(product: p, onRestock: () => onRestock(p), onDelete: () => onDelete(p)),
          const Divider(height: 1, color: AppColors.border),
        ],
        footer,
      ]),
    );
  }
}