import 'package:flutter/material.dart';
import 'Core/Data/models/dashboard_data.dart';
// import '../Data/repositories/dashboard_repository.dart';
import 'Core/Data/models/repositories/dashboard_repository.dart';
import 'dashboard_view.dart';

/// Data load karta hai (repository se) aur loading / error / success handle karta hai.
class DashboardPage extends StatefulWidget {
  final DashboardRepository repository;
  final Future<void> Function()? onAddProduct;
  const DashboardPage({
    super.key,
    required this.repository,
    this.onAddProduct,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<DashboardData> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.load();
  }

  void _reload() => setState(() => _future = widget.repository.load());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DashboardData>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Data load nahi ho saka'),
                const SizedBox(height: 12),
                OutlinedButton(onPressed: _reload, child: const Text('Retry')),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => _reload(),
          child: DashboardView(
            data: snap.data!,
            onRestock: (p) async {
              await widget.repository.restock(p.id);
              _reload();
            },
            onAddProduct: widget.onAddProduct ?? () {},
            onOpenScanner: () {},
            onViewAllLowStock: () {},
            onPurchaseHistory: () {},
          ),
        );
      },
    );
  }
}
