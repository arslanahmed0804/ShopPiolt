import 'package:flutter/material.dart';
import 'Core/Data/models/dashboard_data.dart';
import 'Core/Data/models/product.dart';
import 'widgets/dashboard_header.dart';
import 'widgets/low_stock_card.dart';
import 'widgets/recent_purchases_card.dart';
import 'widgets/smart_lookup_card.dart';
import 'widgets/stats_grid.dart';
import 'widgets/stock_health_card.dart';

class DashboardView extends StatelessWidget {
  final DashboardData data;
  final ValueChanged<Product> onRestock;
  final VoidCallback onAddProduct;
  final VoidCallback onOpenScanner;
  final VoidCallback onViewAllLowStock;
  final VoidCallback onPurchaseHistory;

  const DashboardView({
    super.key,
    required this.data,
    required this.onRestock,
    required this.onAddProduct,
    required this.onOpenScanner,
    required this.onViewAllLowStock,
    required this.onPurchaseHistory,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      final pad = c.maxWidth < 600 ? 16.0 : (c.maxWidth < 1000 ? 24.0 : 32.0);
      final wide = c.maxWidth - pad * 2 >= 1000;

      final lowStock = LowStockCard(
          products: data.lowStock, onRestock: onRestock, onViewAll: onViewAllLowStock);
      final lookup = SmartLookupCard(onOpenScanner: onOpenScanner);
      final health = StockHealthCard(
        score: data.healthScore,
        healthy: data.healthy,
        runningLow: data.runningLow,
        critical: data.critical,
      );

      return SingleChildScrollView(
        padding: EdgeInsets.all(pad),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1240),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              DashboardHeader(userName: data.userName, onAddProduct: onAddProduct),
              const SizedBox(height: 28),
              StatsGrid(data: data),
              const SizedBox(height: 24),
              if (wide)
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 3, child: lowStock),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 2,
                    child: Column(children: [lookup, const SizedBox(height: 24), health]),
                  ),
                ])
              else ...[
                lowStock,
                const SizedBox(height: 24),
                lookup,
                const SizedBox(height: 24),
                health,
              ],
              const SizedBox(height: 24),
              RecentPurchasesCard(purchases: data.recentPurchases, onViewHistory: onPurchaseHistory),
            ]),
          ),
        ),
      );
    });
  }
}