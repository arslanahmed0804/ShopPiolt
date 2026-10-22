import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/utils/format.dart';
import '../../Home-Component/Core/utils/format.dart';
// import '../../Core/widgets/initials_avatar.dart';
import '../../Home-Component/Core/widgets/initials_avatar.dart';
// import '../../Data/models/product.dart';
import '../../Home-Component/Core/Data/models/product.dart';
import 'product_menu.dart';
import 'stock_status_badge.dart';

/// Mobile / chhoti screen ke liye compact row.
class ProductListTile extends StatelessWidget {
  final Product product;
  final VoidCallback onRestock;
  final VoidCallback onDelete;

  const ProductListTile({
    super.key,
    required this.product,
    required this.onRestock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 4, 14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InitialsAvatar(text: product.initials, bg: product.avatarBg, fg: product.avatarFg, size: 46),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.name,
                maxLines: 1, overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text('${product.sku} · ${product.category}',
                style: const TextStyle(color: AppColors.muted, fontSize: 13)),
            const SizedBox(height: 10),
            Wrap(spacing: 10, runSpacing: 6, crossAxisAlignment: WrapCrossAlignment.center, children: [
              StockStatusBadge(status: product.status),
              Text('${product.quantity} units · ${formatRs(product.price)}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 13)),
            ]),
          ]),
        ),
        ProductMenu(onRestock: onRestock, onDelete: onDelete),
      ]),
    );
  }
}