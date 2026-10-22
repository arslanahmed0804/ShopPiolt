import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../../Core/utils/format.dart';
import '../Home-Component/Core/utils/format.dart';
// import '../../Data/models/bill.dart';
import 'Data/bill.dart';
import 'quantity_stepper.dart';

class BillLineTile extends StatelessWidget {
  final BillLine line;
  final ValueChanged<int> onQuantity;
  final VoidCallback onRemove;

  const BillLineTile({
    super.key,
    required this.line,
    required this.onQuantity,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${formatRs(line.product.price)} each',
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                tooltip: 'Remove',
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.close, size: 20, color: AppColors.muted),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              QuantityStepper(
                value: line.quantity,
                max: line.product.quantity,
                onChanged: onQuantity,
              ),
              const Spacer(),
              Text(
                formatRs(line.total),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
