import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/Data/models/product.dart';
import '../Core/widgets/initials_avatar.dart';

class LowStockRow extends StatelessWidget {
  final Product product;
  final VoidCallback onRestock;
  const LowStockRow({super.key, required this.product, required this.onRestock});

  @override
  Widget build(BuildContext context) {
    final ratio = (product.quantity / product.minQuantity).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        InitialsAvatar(text: product.initials, bg: product.avatarBg, fg: product.avatarFg),
        const SizedBox(width: 16),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text(product.sku, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
          ]),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 84,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text.rich(TextSpan(children: [
              TextSpan(text: '${product.quantity}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
              const TextSpan(text: ' units', style: TextStyle(fontSize: 13, color: AppColors.muted)),
            ])),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: ratio,
                minHeight: 4,
                color: AppColors.danger,
                backgroundColor: AppColors.border,
              ),
            ),
          ]),
        ),
        const SizedBox(width: 16),
        OutlinedButton(onPressed: onRestock, child: const Text('Restock')),
      ]),
    );
  }
}