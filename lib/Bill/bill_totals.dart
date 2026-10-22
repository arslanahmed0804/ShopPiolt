import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';
import '../Bill/Data/bill.dart';

/// Panel aur receipt dono mein use hota hai.
class BillTotals extends StatelessWidget {
  final Bill bill;
  const BillTotals({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    String pct(double v) => v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
    return Column(children: [
      _Row('Subtotal', formatRs(bill.subtotal)),
      if (bill.appliedDiscount > 0) _Row('Discount', '- ${formatRs(bill.appliedDiscount)}'),
      if (bill.taxPercent > 0) _Row('Tax (${pct(bill.taxPercent)}%)', formatRs(bill.taxAmount)),
      const SizedBox(height: 10),
      const Divider(height: 1, color: AppColors.border),
      const SizedBox(height: 14),
      Row(children: [
        const Expanded(child: Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
        Text(formatRs(bill.grandTotal),
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
      ]),
    ]);
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(child: Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 15))),
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}