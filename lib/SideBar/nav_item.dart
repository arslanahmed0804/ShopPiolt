import 'package:flutter/material.dart';

enum NavItem {
    bill('Bill', Icons.receipt_long_outlined),
  overview('Overview', Icons.grid_view_rounded),
  products('Products', Icons.inventory_2_outlined),
  vendors('Vendors', Icons.people_outline),
  stockHistory('Stock history', Icons.history);

  final String label;
  final IconData icon;
  const NavItem(this.label, this.icon);
}