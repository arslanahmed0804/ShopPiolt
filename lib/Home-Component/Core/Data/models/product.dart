import 'package:flutter/material.dart';

enum StockStatus { healthy, low, critical }

class Product {
  final String id;
  final String name;
  final String sku;
  final int quantity;
  final int minQuantity;
  final Color avatarBg;
  final Color avatarFg;
  final String category;
  final double price;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.quantity,
    required this.minQuantity,
    required this.avatarBg,
    required this.avatarFg,
    this.category = 'General',
    this.price = 0, required String barcode, required String vendorName, String? imagePath,
  });

  StockStatus get status {
    if (quantity > minQuantity) return StockStatus.healthy;
    if (quantity * 5 > minQuantity * 2) return StockStatus.low;
    return StockStatus.critical;
  }

  String get initials {
    final parts = name.split(' ').where((e) => e.isNotEmpty).toList();
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Product copyWith({
    String? id,
    String? name,
    String? sku,
    int? quantity,
    int? minQuantity,
    Color? avatarBg,
    Color? avatarFg,
    String? category,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      quantity: quantity ?? this.quantity,
      minQuantity: minQuantity ?? this.minQuantity,
      avatarBg: avatarBg ?? this.avatarBg,
      avatarFg: avatarFg ?? this.avatarFg,
      category: category ?? this.category,
      price: price ?? this.price, barcode: '', vendorName: '',
    );
  }
}

class ProductPalette {
  static const _pairs = <List<Color>>[
    [Color(0xFFFFF0C9), Color(0xFFB7791F)],
    [Color(0xFFDDEFFB), Color(0xFF1C6FA3)],
    [Color(0xFFFBE7CF), Color(0xFFC2571A)],
    [Color(0xFFFBE0E4), Color(0xFFC0213F)],
    [Color(0xFFDDF3E8), Color(0xFF2F7D55)],
    [Color(0xFFE6E3F4), Color(0xFF5B4FA8)],
  ];

  static List<Color> pick(String seed) {
    var h = 0;
    for (final c in seed.codeUnits) {
      h = (h * 31 + c) & 0x7fffffff;
    }
    return _pairs[h % _pairs.length];
  }
}