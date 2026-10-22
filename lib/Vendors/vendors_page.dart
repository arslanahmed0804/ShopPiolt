import 'package:flutter/material.dart';
// import '../Data/models/vendor.dart';
import './Data/vendor.dart';
// import '../Data/repositories/vendors_repository.dart';
import 'Data/vendors_repository.dart';
import 'vendors_view.dart';
// import 'widgets/add_vendor_dialog.dart';
import '../Vendors/add_vendor_dialog.dart';

/// Data load + add / activate / delete actions (repository ke through).
class VendorsPage extends StatefulWidget {
  final VendorsRepository repository;
  const VendorsPage({super.key, required this.repository});

  @override
  State<VendorsPage> createState() => _VendorsPageState();
}

class _VendorsPageState extends State<VendorsPage> {
  late Future<List<Vendor>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.fetchVendors();
  }

  void _reload() => setState(() => _future = widget.repository.fetchVendors());

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _add() async {
    final vendor = await AddVendorDialog.show(context);
    if (vendor == null) return;
    await widget.repository.addVendor(vendor);
    _reload();
    _toast('${vendor.name} added');
  }

  Future<void> _toggle(Vendor v) async {
    await widget.repository.setActive(v.id, !v.isActive);
    _reload();
    _toast('${v.name} marked ${v.isActive ? 'inactive' : 'active'}');
  }

  Future<void> _delete(Vendor v) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete vendor?'),
        content: Text('${v.name} will be removed from your vendors.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFFD95A38)),
            ),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await widget.repository.deleteVendor(v.id);
    _reload();
    _toast('${v.name} deleted');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vendor>>(
      future: _future,
      builder: (context, snap) {
        // Reload ke dauran purana data dikhate raho (filters reset na hon)
        if (snap.hasData) {
          return VendorsView(
            vendors: snap.data!,
            onAddVendor: _add,
            onToggleActive: _toggle,
            onDelete: _delete,
          );
        }
        if (snap.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load vendors'),
                const SizedBox(height: 12),
                OutlinedButton(onPressed: _reload, child: const Text('Retry')),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
