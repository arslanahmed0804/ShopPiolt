import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final bool bordered;

  const AppCard({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.color = AppColors.card,
    this.bordered = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        border: bordered ? Border.all(color: AppColors.border) : null,
      ),
      child: child,
    );
  }
}