import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/widgets/section_card.dart';

class StockHealthCard extends StatelessWidget {
  final double score; // 0..1
  final int healthy;
  final int runningLow;
  final int critical;

  const StockHealthCard({
    super.key,
    required this.score,
    required this.healthy,
    required this.runningLow,
    required this.critical,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Stock health',
      subtitle: 'Across all products',
      divider: false,
      trailing: SizedBox(
        width: 72,
        height: 72,
        child: Stack(alignment: Alignment.center, children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: score,
              strokeWidth: 5,
              color: AppColors.lime,
              backgroundColor: AppColors.border,
            ),
          ),
          Text('${(score * 100).round()}%', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
        ]),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
        child: Row(children: [
          Expanded(child: _Stat(value: '$healthy', label: 'Healthy')),
          Expanded(child: _Stat(value: '$runningLow', label: 'Running low')),
          Expanded(child: _Stat(value: '$critical', label: 'Critical', color: AppColors.danger)),
        ]),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  final Color? color;
  const _Stat({required this.value, required this.label, this.color});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
        ],
      );
}