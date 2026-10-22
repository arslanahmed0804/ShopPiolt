import 'package:flutter/material.dart';

import '../dashboard_data.dart';
import '../product.dart';
import '../purchase.dart';

abstract interface class DashboardRepository {
  Future<DashboardData> load();

  Future<void> restock(String productId);
}

class MockDashboardRepository implements DashboardRepository {
  final List<Product> _products = [
    const Product(
      id: 'coffee',
      name: 'Coffee Beans',
      sku: 'CF-1042',
      quantity: 4,
      minQuantity: 10,
      avatarBg: Color(0xFFF4E6D4),
      avatarFg: Color(0xFF785333), barcode: '', vendorName: '',
    ),
    const Product(
      id: 'olive-oil',
      name: 'Olive Oil',
      sku: 'OL-2091',
      quantity: 8,
      minQuantity: 12,
      avatarBg: Color(0xFFE4EEDC),
      avatarFg: Color(0xFF49633D), barcode: '', vendorName: '',
    ),
    const Product(
      id: 'green-tea',
      name: 'Green Tea',
      sku: 'GT-3180',
      quantity: 2,
      minQuantity: 8,
      avatarBg: Color(0xFFDDEFE5),
      avatarFg: Color(0xFF32664A), barcode: '', vendorName: '',
    ),
  ];

  static const _recentPurchases = [
    Purchase(
      id: 'purchase-1',
      vendor: 'Northstar Supply',
      items: 24,
      dateLabel: 'Today',
      amount: 1240.00,
    ),
    Purchase(
      id: 'purchase-2',
      vendor: 'Harvest Goods',
      items: 12,
      dateLabel: 'Yesterday',
      amount: 680.50,
    ),
  ];

  @override
  Future<DashboardData> load() async {
    final lowStock = _products
        .where((product) => product.quantity <= product.minQuantity)
        .toList();

    return DashboardData(
      userName: 'Alex',
      totalProducts: 128,
      addedThisMonth: 12,
      inventoryValue: 48250.75,
      valueChangePct: 8.4,
      lowStockCount: lowStock.length,
      needAttention: lowStock.length,
      activeVendors: 16,
      pendingOrders: 3,
      healthy: 112,
      runningLow: 13,
      critical: 3,
      lowStock: lowStock,
      recentPurchases: _recentPurchases,
    );
  }

  @override
  Future<void> restock(String productId) async {
    final index = _products.indexWhere((product) => product.id == productId);
    if (index == -1) return;

    final product = _products[index];
    _products[index] = Product(
      id: product.id,
      name: product.name,
      sku: product.sku,
      quantity: product.quantity + 10,
      minQuantity: product.minQuantity,
      avatarBg: product.avatarBg,
      avatarFg: product.avatarFg, barcode: '', vendorName: '',
    );
  }
}
