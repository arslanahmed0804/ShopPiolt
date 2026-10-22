import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/widgets/search_field.dart';
import '../Home-Component/Core/widgets/section_card.dart';
import '../Home-Component/Core/Data/models/product.dart';
import 'product_pick_tile.dart';

class ProductPicker extends StatelessWidget {
  final List<Product> products; // already filtered
  final int totalMatches;
  final int Function(Product) inBill;
  final ValueChanged<Product> onAdd;
  final ValueChanged<String> onSearch;

  const ProductPicker({
    super.key,
    required this.products,
    required this.totalMatches,
    required this.inBill,
    required this.onAdd,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Add products',
      subtitle: 'Search your catalog and tap Add',
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: AppSearchField(hint: 'Search by name or SKU…', onChanged: onSearch),
        ),
        const Divider(height: 1, color: AppColors.border),
        if (products.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32),
            child: Text('No products match your search.', style: TextStyle(color: AppColors.muted)),
          ),
        for (final p in products) ...[
          ProductPickTile(product: p, inBill: inBill(p), onAdd: () => onAdd(p)),
          const Divider(height: 1, color: AppColors.border),
        ],
        if (totalMatches > products.length)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Showing ${products.length} of $totalMatches · search to narrow down',
                style: const TextStyle(color: AppColors.muted, fontSize: 13)),
          ),
      ]),
    );
  }
}