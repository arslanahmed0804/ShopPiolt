import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';

class BillingHeader extends StatelessWidget {
  final String billNumber;
  final VoidCallback? onClear; // null = button hidden
  const BillingHeader({super.key, required this.billNumber, this.onClear});

  @override
  Widget build(BuildContext context) {
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SALES',
          style: TextStyle(
            color: AppColors.muted,
            letterSpacing: 2,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'New bill',
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            height: 1.1,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '$billNumber · ${formatDateTime(DateTime.now())}',
          style: const TextStyle(color: AppColors.muted, fontSize: 17),
        ),
      ],
    );
    final clear = onClear == null
        ? null
        : OutlinedButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Clear bill'),
          );
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 600 || clear == null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text,
              if (clear != null) ...[const SizedBox(height: 16), clear],
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: text),
            clear,
          ],
        );
      },
    );
  }
}
