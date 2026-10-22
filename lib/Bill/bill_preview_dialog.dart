import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Bill/Data/bill.dart';
import 'bill_receipt.dart';

/// Bill generate hone ke baad receipt dikhata hai.
class BillPreviewDialog extends StatefulWidget {
  final Bill bill;
  const BillPreviewDialog({super.key, required this.bill});

  static Future<void> show(BuildContext context, Bill bill) {
    return showDialog<void>(context: context, builder: (_) => BillPreviewDialog(bill: bill));
  }

  @override
  State<BillPreviewDialog> createState() => _BillPreviewDialogState();
}

class _BillPreviewDialogState extends State<BillPreviewDialog> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: billAsText(widget.bill)));
    if (mounted) setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.check, color: AppColors.dark),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Text('Bill generated', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
              ),
            ]),
            const SizedBox(height: 18),
            BillReceipt(bill: widget.bill),
            const SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _copy,
                  icon: Icon(_copied ? Icons.check : Icons.copy_outlined, size: 18),
                  label: Text(_copied ? 'Copied' : 'Copy text'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.dark,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Done', style: TextStyle(fontSize: 16)),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}