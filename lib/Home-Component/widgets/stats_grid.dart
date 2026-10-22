import 'package:flutter/material.dart';
import '../Core/utils/format.dart';
import '../Core/Data/models/dashboard_data.dart';
import 'stat_card.dart';

class StatsGrid extends StatelessWidget {
  final DashboardData data;
  const StatsGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final cards = [
      StatCard(
        icon: Icons.inventory_2_outlined,
        iconBg: const Color(0xFFE6EADF),
        label: 'Total products',
        value: '${data.totalProducts}',
        caption: '${data.addedThisMonth} added this month',
      ),
      StatCard(
        icon: Icons.trending_up,
        iconBg: const Color(0xFFDDF3E8),
        label: 'Inventory value',
        value: formatRsShort(data.inventoryValue),
        caption: '+${data.valueChangePct}% from last month',
      ),
      StatCard(
        icon: Icons.archive_outlined,
        iconBg: const Color(0xFFF8E1D6),
        label: 'Low stock',
        value: '${data.lowStockCount}',
        caption: '${data.needAttention} need attention today',
        badge: 'ACTION',
      ),
      StatCard(
        icon: Icons.people_outline,
        iconBg: const Color(0xFFE6E3F4),
        label: 'Active vendors',
        value: '${data.activeVendors}',
        caption: '${data.pendingOrders} orders pending',
      ),
    ];

    return LayoutBuilder(builder: (context, c) {
      const gap = 16.0;
      final cols = c.maxWidth >= 1000 ? 4 : (c.maxWidth >= 360 ? 2 : 1);
      final w = (c.maxWidth - gap * (cols - 1)) / cols;
      return Wrap(
        spacing: gap,
        runSpacing: gap,
        children: [for (final card in cards) SizedBox(width: w, child: card)],
      );
    });
  }
}