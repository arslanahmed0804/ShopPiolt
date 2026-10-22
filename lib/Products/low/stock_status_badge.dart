import 'package:flutter/material.dart';
// import '../../Data/models/product.dart';
import '../../Home-Component/Core/Data/models/product.dart';

extension StockStatusStyle on StockStatus {
  String get label {
    switch (this) {
      case StockStatus.healthy:
        return 'Healthy';
      case StockStatus.low:
        return 'Running low';
      case StockStatus.critical:
        return 'Critical';
    }
  }

  Color get fg {
    switch (this) {
      case StockStatus.healthy:
        return const Color(0xFF2F7D55);
      case StockStatus.low:
        return const Color(0xFFB7791F);
      case StockStatus.critical:
        return const Color(0xFFD95A38);
    }
  }

  Color get bg {
    switch (this) {
      case StockStatus.healthy:
        return const Color(0xFFDDF3E8);
      case StockStatus.low:
        return const Color(0xFFFFF0C9);
      case StockStatus.critical:
        return const Color(0xFFFBE6DC);
    }
  }
}

class StockStatusBadge extends StatelessWidget {
  final StockStatus status;
  const StockStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: status.bg, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.circle, size: 7, color: status.fg),
        const SizedBox(width: 6),
        Text(status.label,
            style: TextStyle(color: status.fg, fontSize: 13, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}