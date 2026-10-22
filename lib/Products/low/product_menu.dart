import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';

class ProductMenu extends StatelessWidget {
  final VoidCallback onRestock;
  final VoidCallback onDelete;
  const ProductMenu({super.key, required this.onRestock, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Actions',
      icon: const Icon(Icons.more_horiz, color: AppColors.muted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (v) => v == 'restock' ? onRestock() : onDelete(),
      itemBuilder: (_) => const [
        PopupMenuItem(value: 'restock', child: Text('Restock')),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: AppColors.danger)),
        ),
      ],
    );
  }
}