import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/widgets/search_field.dart';

class TopBar extends StatelessWidget {
  final VoidCallback onMenuTap;
  final VoidCallback onScan;
  final bool compact;
  final bool hasNotifications;
  final ValueChanged<String>? onSearch;

  const TopBar({
    super.key,
    required this.onMenuTap,
    required this.onScan,
    this.compact = false,
    this.hasNotifications = true,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 24),
      decoration: const BoxDecoration(
        color: AppColors.bg,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(children: [
        _SquareButton(icon: Icons.menu, onTap: onMenuTap, tooltip: 'Toggle sidebar'),
        const SizedBox(width: 12),
        Expanded(child: AppSearchField(onChanged: onSearch)),
        const SizedBox(width: 12),
        Stack(children: [
          _SquareButton(icon: Icons.notifications_none, onTap: () {}),
          if (hasNotifications)
            Positioned(
              right: 14,
              top: 14,
              child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: AppColors.danger, shape: BoxShape.circle)),
            ),
        ]),
        const SizedBox(width: 12),
        compact
            ? _SquareButton(icon: Icons.qr_code_scanner, onTap: onScan, dark: true, tooltip: 'Scan product')
            : FilledButton.icon(
                onPressed: onScan,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('Scan product', style: TextStyle(fontSize: 17)),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.dark,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                ),
              ),
      ]),
    );
  }
}

class _SquareButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool dark;
  final String? tooltip;
  const _SquareButton({required this.icon, required this.onTap, this.dark = false, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: Material(
        color: dark ? AppColors.dark : Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: dark ? null : Border.all(color: AppColors.border),
            ),
            child: Icon(icon, color: dark ? Colors.white : AppColors.ink),
          ),
        ),
      ),
    );
  }
}