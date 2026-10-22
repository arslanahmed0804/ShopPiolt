import 'package:flutter/material.dart';
import '../Bill/Data/bill.dart';
// import '../Bill/Data/product.dart;
import '../Home-Component/Core/Data/models/product.dart';
// import '../Bill/Data/repositories/billing_repository.dart';
import '../Bill/Data/billing_repository.dart';
// import '../Bill/Data/repositories/products_repository.dart';
import '../Products/Data/repositories/products_repository.dart';
import 'billing_view.dart';
// import 'widgets/bill_preview_dialog.dart';
import '../Bill/bill_preview_dialog.dart';

class _BillingData {
  final List<Product> products;
  final String billNumber;
  const _BillingData(this.products, this.billNumber);
}

/// Products + next bill number load karta hai, bill create karta hai,
/// phir receipt dikha kar naya khali bill start karta hai.
class BillingPage extends StatefulWidget {
  final ProductsRepository productsRepository;
  final BillingRepository billingRepository;

  const BillingPage({
    super.key,
    required this.productsRepository,
    required this.billingRepository,
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  late Future<_BillingData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_BillingData> _load() async {
    final r = await Future.wait([
      widget.productsRepository.fetchProducts(),
      widget.billingRepository.nextBillNumber(),
    ]);
    return _BillingData(r[0] as List<Product>, r[1] as String);
  }

  void _reload() => setState(() => _future = _load());

  Future<void> _generate(Bill bill) async {
    try {
      await widget.billingRepository.createBill(bill);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Could not create the bill. Please try again.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }
    _reload(); // stock update + naya bill number
    if (!mounted) return;
    await BillPreviewDialog.show(context, bill);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_BillingData>(
      future: _future,
      builder: (context, snap) {
        if (snap.hasData) {
          final d = snap.data!;
          return BillingView(
            // key badalne se naya bill number aate hi cart reset ho jata hai
            key: ValueKey(d.billNumber),
            products: d.products,
            billNumber: d.billNumber,
            onGenerate: _generate,
          );
        }
        if (snap.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load billing'),
                const SizedBox(height: 12),
                OutlinedButton(onPressed: _reload, child: const Text('Retry')),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
