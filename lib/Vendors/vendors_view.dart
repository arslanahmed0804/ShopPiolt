import 'package:flutter/material.dart';
// import '../Core/widgets/page_container.dart';
import '../Products/Core/widgets/page_container.dart';
// import '../Core/widgets/search_field.dart';
import '../Home-Component/Core/widgets/search_field.dart';
// import '../Data/models/vendor.dart';
import '../Vendors/Data/vendor.dart';
// import 'widgets/vendor_filter_chips.dart';
import '../Vendors/vendor_filter_chips.dart';
// import 'widgets/vendors_empty_state.dart';
import '../Vendors/vendors_empty_state.dart';
// import 'widgets/vendors_grid.dart';
import '../Vendors/vendors_grid.dart';
// import 'widgets/vendors_header.dart';
import '../Vendors/vendors_header.dart';
// import 'widgets/vendors_summary.dart';
import '../Vendors/vendors_summary.dart';

/// Search + filter ka local state yahan hai.
class VendorsView extends StatefulWidget {
  final List<Vendor> vendors;
  final VoidCallback onAddVendor;
  final ValueChanged<Vendor> onToggleActive;
  final ValueChanged<Vendor> onDelete;

  const VendorsView({
    super.key,
    required this.vendors,
    required this.onAddVendor,
    required this.onToggleActive,
    required this.onDelete,
  });

  @override
  State<VendorsView> createState() => _VendorsViewState();
}

class _VendorsViewState extends State<VendorsView> {
  String _query = '';
  VendorFilter _filter = VendorFilter.all;

  List<Vendor> get _searched {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return widget.vendors;
    return widget.vendors
        .where(
          (v) =>
              v.name.toLowerCase().contains(q) ||
              v.contactPerson.toLowerCase().contains(q) ||
              v.city.toLowerCase().contains(q),
        )
        .toList();
  }

  void _clear() => setState(() {
    _query = '';
    _filter = VendorFilter.all;
  });

  @override
  Widget build(BuildContext context) {
    final all = widget.vendors;
    final searched = _searched;
    final shown = switch (_filter) {
      VendorFilter.all => searched,
      VendorFilter.active => searched.where((v) => v.isActive).toList(),
      VendorFilter.inactive => searched.where((v) => !v.isActive).toList(),
    };
    final counts = {
      VendorFilter.all: searched.length,
      VendorFilter.active: searched.where((v) => v.isActive).length,
      VendorFilter.inactive: searched.where((v) => !v.isActive).length,
    };
    final active = all.where((v) => v.isActive).toList();

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VendorsHeader(
            total: all.length,
            active: active.length,
            onAddVendor: widget.onAddVendor,
          ),
          const SizedBox(height: 28),
          VendorsSummary(
            activeVendors: active.length,
            pendingOrders: all.fold(0, (s, v) => s + v.pendingOrders),
            outstanding: all.fold(0.0, (s, v) => s + v.outstanding),
          ),
          const SizedBox(height: 24),
          AppSearchField(
            hint: 'Search by name, contact or city…',
            onChanged: (v) => setState(() => _query = v),
          ),
          const SizedBox(height: 16),
          VendorFilterChips(
            selected: _filter,
            counts: counts,
            onChanged: (f) => setState(() => _filter = f),
          ),
          const SizedBox(height: 20),
          if (shown.isEmpty)
            VendorsEmptyState(onClear: _clear)
          else
            VendorsGrid(
              vendors: shown,
              onToggleActive: widget.onToggleActive,
              onDelete: widget.onDelete,
            ),
        ],
      ),
    );
  }
}
