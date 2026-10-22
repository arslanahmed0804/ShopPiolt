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
import 'stock_level.dart';
import 'stock_status_badge.dart';

/// Header aur rows dono yahi flex values use karte hain.
/// Order: product, category, stock, price, status
const kProductColumnFlex = [4, 2, 2, 2, 2];
const kProductMenuWidth = 48.0;

class ProductTableRow extends StatelessWidget {
  final Product product;
  final VoidCallback onRestock;
  final VoidCallback onDelete;

  const ProductTableRow({
    super.key,
    required this.product,
    required this.onRestock,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const f = kProductColumnFlex;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(children: [
        Expanded(
          flex: f[0],
          child: Row(children: [
            InitialsAvatar(text: product.initials, bg: product.avatarBg, fg: product.avatarFg, size: 46),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(product.sku, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
              ]),
            ),
          ]),
        ),
        Expanded(
          flex: f[1],
          child: Text(product.category,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: AppColors.muted, fontSize: 15)),
        ),
        Expanded(flex: f[2], child: StockLevel(product: product)),
        Expanded(
          flex: f[3],
          child: Text(formatRs(product.price), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: f[4],
          child: Align(alignment: Alignment.centerLeft, child: StockStatusBadge(status: product.status)),
        ),
        SizedBox(
          width: kProductMenuWidth,
          child: ProductMenu(onRestock: onRestock, onDelete: onDelete),
        ),
      ]),
    );
  }
}