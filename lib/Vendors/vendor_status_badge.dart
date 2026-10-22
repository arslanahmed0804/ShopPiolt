import 'package:flutter/material.dart';

class VendorStatusBadge extends StatelessWidget {
  final bool isActive;
  const VendorStatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final fg = isActive ? const Color(0xFF2F7D55) : const Color(0xFF6E7873);
    final bg = isActive ? const Color(0xFFDDF3E8) : const Color(0xFFEDEDE8);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.circle, size: 7, color: fg),
        const SizedBox(width: 6),
        Text(isActive ? 'Active' : 'Inactive',
            style: TextStyle(color: fg, fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}