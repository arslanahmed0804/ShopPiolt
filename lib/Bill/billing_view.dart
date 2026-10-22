import 'package:flutter/material.dart';
// import '../Core/widgets/page_container.dart';
import '../Products/Core/widgets/page_container.dart';
// import '../Data/models/bill.dart';
import '../Bill/Data/bill.dart';
// import '../Data/models/product.dart';
import '../Home-Component/Core/Data/models/product.dart';
// import 'widgets/bill_panel.dart';
import '../Bill/bill_panel.dart';
// import 'widgets/billing_header.dart';
import '../Bill/billing_header.dart';
// import 'widgets/product_picker.dart';
import '../Bill/product_picker.dart';

/// Cart (bill lines) ka local state yahan hai.
class BillingView extends StatefulWidget {
  final List<Product> products;
  final String billNumber;
  final Future<void> Function(Bill bill) onGenerate;

  const BillingView({
    super.key,
    required this.products,
    required this.billNumber,
    required this.onGenerate,
  });

  @override
  State<BillingView> createState() => _BillingViewState();
}

class _BillingViewState extends State<BillingView> {
  static const _maxShown = 8;
  final List<BillLine> _lines = [];
  final _customer = TextEditingController();
  final _discount = TextEditingController();
  final _tax = TextEditingController();
  PaymentMethod _payment = PaymentMethod.cash;
  String _query = '';
  bool _saving = false;

  @override
  void dispose() {
    _customer.dispose();
    _discount.dispose();
    _tax.dispose();
    super.dispose();
  }

  int _inBill(Product p) {
    final i = _lines.indexWhere((l) => l.product.id == p.id);
    return i == -1 ? 0 : _lines[i].quantity;
  }

  void _add(Product p) {
    setState(() {
      final i = _lines.indexWhere((l) => l.product.id == p.id);
      if (i == -1) {
        if (p.quantity > 0) _lines.add(BillLine(product: p, quantity: 1));
      } else if (_lines[i].quantity < p.quantity) {
        _lines[i] = _lines[i].copyWith(quantity: _lines[i].quantity + 1);
      }
    });
  }

  void _setQuantity(BillLine line, int q) {
    setState(() {
      final i = _lines.indexWhere((l) => l.product.id == line.product.id);
      if (i == -1) return;
      if (q <= 0) {
        _lines.removeAt(i);
      } else {
        _lines[i] = _lines[i].copyWith(
          quantity: q > line.product.quantity ? line.product.quantity : q,
        );
      }
    });
  }

  void _clear() => setState(() {
    _lines.clear();
    _customer.clear();
    _discount.clear();
    _tax.clear();
    _payment = PaymentMethod.cash;
  });

  double _num(TextEditingController c) =>
      (double.tryParse(c.text.trim()) ?? 0).abs();

  Bill get _draft => Bill(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    number: widget.billNumber,
    customerName: _customer.text.trim().isEmpty
        ? 'Walk-in customer'
        : _customer.text.trim(),
    paymentMethod: _payment,
    lines: List.unmodifiable(_lines),
    discount: _num(_discount),
    taxPercent: _num(_tax),
    createdAt: DateTime.now(),
  );

  Future<void> _generate() async {
    if (_lines.isEmpty) return;
    setState(() => _saving = true);
    try {
      await widget.onGenerate(_draft);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final matches = q.isEmpty
        ? widget.products
        : widget.products
              .where(
                (p) =>
                    p.name.toLowerCase().contains(q) ||
                    p.sku.toLowerCase().contains(q),
              )
              .toList();

    final picker = ProductPicker(
      products: matches.take(_maxShown).toList(),
      totalMatches: matches.length,
      inBill: _inBill,
      onAdd: _add,
      onSearch: (v) => setState(() => _query = v),
    );
    final panel = BillPanel(
      bill: _draft,
      customer: _customer,
      discount: _discount,
      tax: _tax,
      onFieldsChanged: () => setState(() {}),
      onQuantity: _setQuantity,
      onRemove: (l) => _setQuantity(l, 0),
      onPayment: (m) => setState(() => _payment = m),
      onGenerate: _generate,
      saving: _saving,
    );

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BillingHeader(
            billNumber: widget.billNumber,
            onClear: _lines.isEmpty ? null : _clear,
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, c) {
              if (c.maxWidth >= 1000) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: picker),
                    const SizedBox(width: 24),
                    Expanded(flex: 2, child: panel),
                  ],
                );
              }
              return Column(
                children: [picker, const SizedBox(height: 24), panel],
              );
            },
          ),
        ],
      ),
    );
  }
}
