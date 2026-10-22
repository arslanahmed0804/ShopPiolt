import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';
import '../Home-Component/Core/widgets/app_card.dart';

class VendorsSummary extends StatelessWidget {
  final int activeVendors;
  final int pendingOrders;
  final double outstanding;

  const VendorsSummary({
    super.key,
    required this.activeVendors,
    required this.pendingOrders,
    required this.outstanding,
  });

  @override
  Widget build(BuildContext context) {
    final tiles = [
      _Tile(
        icon: Icons.people_outline,
        iconBg: const Color(0xFFE6E3F4),
        label: 'Active vendors',
        value: '$activeVendors',
      ),
      _Tile(
        icon: Icons.local_shipping_outlined,
        iconBg: const Color(0xFFFFF0C9),
        label: 'Pending orders',
        value: '$pendingOrders',
      ),
      _Tile(
        icon: Icons.account_balance_wallet_outlined,
        iconBg: const Color(0xFFF8E1D6),
        label: 'Outstanding balance',
        value: formatRs(outstanding),
      ),
    ];
    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth < 700) {
        return Column(children: [
          for (var i = 0; i < tiles.length; i++) ...[
            tiles[i],
            if (i != tiles.length - 1) const SizedBox(height: 12),
          ],
        ]);
      }
      return Row(children: [
        for (var i = 0; i < tiles.length; i++) ...[
          Expanded(child: tiles[i]),
          if (i != tiles.length - 1) const SizedBox(width: 16),
        ],
      ]);
    });
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;
  const _Tile({required this.icon, required this.iconBg, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(16)),
          child: Icon(icon, color: AppColors.ink),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 15)),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(value,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
            ),
          ]),
        ),
      ]),
    );
  }
}