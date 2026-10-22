import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/widgets/app_card.dart';

class StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String value;
  final String caption;
  final String? badge;

  const StatCard({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.caption,
    this.iconColor = AppColors.ink,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(18)),
              child: Icon(icon, color: iconColor),
            ),
            const Spacer(),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: const Color(0xFFFBE6DC), borderRadius: BorderRadius.circular(20)),
                child: Text(badge!,
                    style: const TextStyle(color: AppColors.danger, fontSize: 12, fontWeight: FontWeight.w700)),
              ),
          ]),
          const SizedBox(height: 22),
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 17)),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(value,
                style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w800, letterSpacing: -1)),
          ),
          const SizedBox(height: 6),
          Text(caption, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
        ],
      ),
    );
  }
}