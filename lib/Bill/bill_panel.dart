import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
// import '../../Core/utils/format.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/utils/format.dart';

// import '../../Core/widgets/app_card.dart';
import '../Home-Component/Core/widgets/app_card.dart';

// import '../../Data/models/bill.dart';
import '../Bill/Data/bill.dart';
import 'bill_line_tile.dart';
import 'bill_totals.dart';
import 'payment_method_selector.dart';

/// Right side: customer, items, discount/tax, totals, payment, Generate button.
class BillPanel extends StatelessWidget {
  final Bill bill; // draft
  final TextEditingController customer;
  final TextEditingController discount;
  final TextEditingController tax;
  final VoidCallback onFieldsChanged;
  final void Function(BillLine line, int quantity) onQuantity;
  final ValueChanged<BillLine> onRemove;
  final ValueChanged<PaymentMethod> onPayment;
  final VoidCallback onGenerate;
  final bool saving;

  const BillPanel({
    super.key,
    required this.bill,
    required this.customer,
    required this.discount,
    required this.tax,
    required this.onFieldsChanged,
    required this.onQuantity,
    required this.onRemove,
    required this.onPayment,
    required this.onGenerate,
    required this.saving,
  });

  InputDecoration _dec(
    String label, {
    String? hint,
    String? prefix,
    String? suffix,
  }) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: c),
    );
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixText: prefix,
      suffixText: suffix,
      filled: true,
      fillColor: AppColors.bg,
      border: b(Colors.transparent),
      enabledBorder: b(Colors.transparent),
      focusedBorder: b(AppColors.sidebar),
    );
  }

  @override
  Widget build(BuildContext context) {
    final empty = bill.lines.isEmpty;
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Bill details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${bill.itemCount} items',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          TextField(
            controller: customer,
            textCapitalization: TextCapitalization.words,
            decoration: _dec('Customer name', hint: 'Walk-in customer'),
          ),
          const SizedBox(height: 8),
          if (empty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 36),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 38,
                    color: AppColors.muted,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No items yet',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add products from the list to start this bill.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.muted, fontSize: 14),
                  ),
                ],
              ),
            )
          else
            Column(
              children: [
                for (final line in bill.lines) ...[
                  BillLineTile(
                    line: line,
                    onQuantity: (q) => onQuantity(line, q),
                    onRemove: () => onRemove(line),
                  ),
                  const Divider(height: 1, color: AppColors.border),
                ],
              ],
            ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: discount,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => onFieldsChanged(),
                  decoration: _dec('Discount', prefix: 'Rs. '),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: tax,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => onFieldsChanged(),
                  decoration: _dec('Tax', suffix: '%'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BillTotals(bill: bill),
          const SizedBox(height: 20),
          const Text(
            'Payment method',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          PaymentMethodSelector(
            selected: bill.paymentMethod,
            onChanged: onPayment,
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: (empty || saving) ? null : onGenerate,
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.dark,
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: saving
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Generate bill${empty ? '' : ' · ${formatRs(bill.grandTotal)}'}',
                    style: const TextStyle(fontSize: 17),
                  ),
          ),
        ],
      ),
    );
  }
}
