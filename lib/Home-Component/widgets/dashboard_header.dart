import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/utils/format.dart';

class DashboardHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onAddProduct;
  const DashboardHeader({super.key, required this.userName, required this.onAddProduct});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(formatLongDate(now),
            style: const TextStyle(color: AppColors.muted, letterSpacing: 2, fontWeight: FontWeight.w600, fontSize: 14)),
        const SizedBox(height: 6),
        Text('${greeting(now)}, $userName.',
            style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w800, height: 1.1, letterSpacing: -1)),
        const SizedBox(height: 10),
        const Text('Here’s what’s happening across your inventory today.',
            style: TextStyle(color: AppColors.muted, fontSize: 17)),
      ],
    );
    final button = OutlinedButton.icon(
      onPressed: onAddProduct,
      icon: const Icon(Icons.add),
      label: const Text('Add product'),
    );

    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth < 600) {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          text,
          const SizedBox(height: 16),
          button,
        ]);
      }
      return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Expanded(child: text),
        button,
      ]);
    });
  }
}