import 'package:flutter/material.dart';
import '../../Home-Component/Core/theme/app_colors.dart';
import '../../Home-Component/Core/Data/models/product.dart';
// import 'stock_status_badge.dart';
import '../low/stock_status_badge.dart';

class StockStatusChips extends StatelessWidget {
  final StockStatus? selected; // null = All
  final Map<StockStatus?, int> counts;
  final ValueChanged<StockStatus?> onChanged;

  const StockStatusChips({
    super.key,
    required this.selected,
    required this.counts,
    required this.onChanged,
  });

  static const _options = <StockStatus?>[
    null,
    StockStatus.healthy,
    StockStatus.low,
    StockStatus.critical,
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, runSpacing: 10, children: [
      for (final s in _options)
        _Chip(
          label: s == null ? 'All' : s.label,
          count: counts[s] ?? 0,
          selected: s == selected,
          onTap: () => onChanged(s),
        ),
    ]);
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.count, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.dark : Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: selected ? AppColors.dark : AppColors.border),
          ),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: label,
              style: TextStyle(
                  color: selected ? Colors.white : AppColors.ink, fontWeight: FontWeight.w600, fontSize: 15),
            ),
            TextSpan(
              text: '  $count',
              style: TextStyle(color: selected ? AppColors.lime : AppColors.muted, fontSize: 15),
            ),
          ])),
        ),
      ),
    );
  }
}