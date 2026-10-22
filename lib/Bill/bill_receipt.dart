import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';
import '../Bill/Data/bill.dart';
import 'bill_totals.dart';

const kStoreName = "Ahmed's Mart";

/// Read-only bill. Bills history page mein bhi reuse hoga.
class BillReceipt extends StatelessWidget {
  final Bill bill;
  const BillReceipt({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Center(
          child: Text(kStoreName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text('${bill.number} · ${formatDateTime(bill.createdAt)}',
              style: const TextStyle(color: AppColors.muted, fontSize: 13)),
        ),
        const SizedBox(height: 14),
        _Meta('Customer', bill.customerName),
        _Meta('Payment', bill.paymentMethod.label),
        const SizedBox(height: 10),
        const Divider(color: AppColors.border),
        for (final l in bill.lines)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l.product.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  Text('${l.quantity} × ${formatRs(l.product.price)}',
                      style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                ]),
              ),
              Text(formatRs(l.total), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ]),
          ),
        const Divider(color: AppColors.border),
        const SizedBox(height: 6),
        BillTotals(bill: bill),
        const SizedBox(height: 18),
        const Center(
          child: Text('Thank you for shopping!', style: TextStyle(color: AppColors.muted, fontSize: 13)),
        ),
      ]),
    );
  }
}

class _Meta extends StatelessWidget {
  final String label;
  final String value;
  const _Meta(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(children: [
          Expanded(child: Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 14))),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ]),
      );
}

/// Plain-text version (clipboard / WhatsApp share ke liye).
String billAsText(Bill b) {
  final s = StringBuffer()
    ..writeln(kStoreName)
    ..writeln('${b.number} · ${formatDateTime(b.createdAt)}')
    ..writeln('Customer: ${b.customerName}')
    ..writeln('Payment: ${b.paymentMethod.label}')
    ..writeln('------------------------');
  for (final l in b.lines) {
    s.writeln('${l.product.name}  ${l.quantity} x ${formatRs(l.product.price)} = ${formatRs(l.total)}');
  }
  s.writeln('------------------------');
  s.writeln('Subtotal: ${formatRs(b.subtotal)}');
  if (b.appliedDiscount > 0) s.writeln('Discount: -${formatRs(b.appliedDiscount)}');
  if (b.taxPercent > 0) s.writeln('Tax (${b.taxPercent}%): ${formatRs(b.taxAmount)}');
  s.writeln('TOTAL: ${formatRs(b.grandTotal)}');
  return s.toString();
}