import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';
// import '../../Core/utils/format.dart';
// import '../../Core/widgets/initials_avatar.dart';
import '../Home-Component/Core/widgets/initials_avatar.dart';
// import '../../Data/models/product.dart';
import '../Home-Component/Core/Data/models/product.dart';

class ProductPickTile extends StatelessWidget {
  final Product product;
  final int inBill; // is bill mein kitni quantity
  final VoidCallback onAdd;

  const ProductPickTile({
    super.key,
    required this.product,
    required this.inBill,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final outOfStock = product.quantity <= 0;
    final maxed = inBill >= product.quantity;
    final label = outOfStock ? 'Out of stock' : (maxed ? 'Max' : 'Add');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          InitialsAvatar(
            text: product.initials,
            bg: product.avatarBg,
            fg: product.avatarFg,
            size: 46,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${formatRs(product.price)} · ${product.quantity} in stock'
                  '${inBill > 0 ? ' · $inBill in bill' : ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: (outOfStock || maxed) ? null : onAdd,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
