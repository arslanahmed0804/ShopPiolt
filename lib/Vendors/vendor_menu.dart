import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class VendorMenu extends StatelessWidget {
  final bool isActive;
  final VoidCallback onToggleActive;
  final VoidCallback onDelete;

  const VendorMenu({
    super.key,
    required this.isActive,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Actions',
      icon: const Icon(Icons.more_horiz, color: AppColors.muted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onSelected: (v) => v == 'toggle' ? onToggleActive() : onDelete(),
      itemBuilder: (_) => [
        PopupMenuItem(value: 'toggle', child: Text(isActive ? 'Mark inactive' : 'Mark active')),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: AppColors.danger)),
        ),
      ],
    );
  }
}