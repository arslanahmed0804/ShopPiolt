import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Data/models/product.dart';
import '../../Home-Component/Core/Data/models/product.dart';
import 'stock_status_badge.dart';

class StockLevel extends StatelessWidget {
  final Product product;
  const StockLevel({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ratio = (product.quantity / (product.minQuantity * 2)).clamp(0.0, 1.0);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text.rich(TextSpan(children: [
        TextSpan(text: '${product.quantity}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const TextSpan(text: ' units', style: TextStyle(fontSize: 13, color: AppColors.muted)),
      ])),
      const SizedBox(height: 6),
      SizedBox(
        width: 84,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 4,
            color: product.status.fg,
            backgroundColor: AppColors.border,
          ),
        ),
      ),
    ]);
  }
}