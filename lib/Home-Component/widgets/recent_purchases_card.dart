import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/Data/models/purchase.dart';
import '../Core/widgets/section_card.dart';
import 'purchase_tile.dart';

class RecentPurchasesCard extends StatelessWidget {
  final List<Purchase> purchases;
  final VoidCallback onViewHistory;
  const RecentPurchasesCard({super.key, required this.purchases, required this.onViewHistory});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Recent purchases',
      subtitle: 'Latest supplier orders recorded',
      actionLabel: 'Purchase history',
      onAction: onViewHistory,
      child: LayoutBuilder(builder: (context, c) {
        final tiles = [for (final p in purchases) PurchaseTile(purchase: p)];
        if (c.maxWidth >= 800) {
          return IntrinsicHeight(
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              for (var i = 0; i < tiles.length; i++) ...[
                Expanded(child: tiles[i]),
                if (i != tiles.length - 1) const VerticalDivider(width: 1, color: AppColors.border),
              ],
            ]),
          );
        }
        return Column(children: [
          for (var i = 0; i < tiles.length; i++) ...[
            tiles[i],
            if (i != tiles.length - 1) const Divider(height: 1, color: AppColors.border),
          ],
        ]);
      }),
    );
  }
}