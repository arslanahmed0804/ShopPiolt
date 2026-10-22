import 'package:flutter/material.dart';
// import '../../Data/models/vendor.dart';
import '../Vendors/Data/vendor.dart';
import 'vendor_card.dart';

/// 3 columns (wide) / 2 (tablet) / 1 (mobile)
class VendorsGrid extends StatelessWidget {
  final List<Vendor> vendors;
  final ValueChanged<Vendor> onToggleActive;
  final ValueChanged<Vendor> onDelete;

  const VendorsGrid({
    super.key,
    required this.vendors,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const gap = 16.0;
        final cols = c.maxWidth >= 1000 ? 3 : (c.maxWidth >= 640 ? 2 : 1);
        final w = (c.maxWidth - gap * (cols - 1)) / cols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final v in vendors)
              SizedBox(
                width: w,
                child: VendorCard(
                  vendor: v,
                  onToggleActive: () => onToggleActive(v),
                  onDelete: () => onDelete(v),
                ),
              ),
          ],
        );
      },
    );
  }
}
