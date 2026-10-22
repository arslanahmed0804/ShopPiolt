import 'product.dart';
import 'purchase.dart';

class DashboardData {
  final String userName;
  final int totalProducts;
  final int addedThisMonth;
  final double inventoryValue;
  final double valueChangePct;
  final int lowStockCount;
  final int needAttention;
  final int activeVendors;
  final int pendingOrders;
  final int healthy;
  final int runningLow;
  final int critical;
  final List<Product> lowStock;
  final List<Purchase> recentPurchases;

  const DashboardData({
    required this.userName,
    required this.totalProducts,
    required this.addedThisMonth,
    required this.inventoryValue,
    required this.valueChangePct,
    required this.lowStockCount,
    required this.needAttention,
    required this.activeVendors,
    required this.pendingOrders,
    required this.healthy,
    required this.runningLow,
    required this.critical,
    required this.lowStock,
    required this.recentPurchases,
  });

  double get healthScore => totalProducts == 0 ? 0 : healthy / totalProducts;
}