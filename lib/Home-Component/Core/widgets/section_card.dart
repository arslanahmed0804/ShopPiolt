import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'app_card.dart';

/// Title + subtitle + "View all" header, neeche koi bhi child.
class SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;
  final Widget? trailing;
  final Widget child;
  final bool divider;

  const SectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.actionLabel,
    this.onAction,
    this.trailing,
    this.divider = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                ?trailing,
                if (actionLabel != null)
                  TextButton.icon(
                    onPressed: onAction,
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: Text(
                      actionLabel!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.sidebar,
                    ),
                  ),
              ],
            ),
          ),
          if (divider) const Divider(height: 1, color: AppColors.border),
          child,
        ],
      ),
    );
  }
}
