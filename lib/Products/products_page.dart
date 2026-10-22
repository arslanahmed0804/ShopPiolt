import 'package:flutter/material.dart';
// import '../Data/models/product.dart';
import '../Home-Component/Core/Data/models/product.dart';
// import '../Data/repositories/products_repository.dart';
// import '../Home-Component/Core/Data/repositories/products_repository.dart';
import '../Products/Data/repositories/products_repository.dart';
// import 'products_view.dart';
import '../Products/delete/products_view.dart';

// import 'widgets/add_product_dialog.dart';
// import '../Products/button/add_product_dialog.dart';
import 'low/add_product_form.dart';

/// Data load + add / restock / delete actions (repository ke through).
class ProductsPage extends StatefulWidget {
  final ProductsRepository repository;
  const ProductsPage({super.key, required this.repository});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Product>> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.repository.fetchProducts();
  }

  void _reload() => setState(() => _future = widget.repository.fetchProducts());

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(msg), behavior: SnackBarBehavior.floating),
      );
  }

  Future<void> _add(List<Product> current) async {
    final cats = (current.map((p) => p.category).toSet().toList()..sort());
    final product = await AddProductDialog.show(context, cats);
    if (product == null) return;
    await widget.repository.addProduct(product);
    _reload();
    _toast('${product.name} added');
  }

  Future<void> _restock(Product p) async {
    await widget.repository.restock(p.id);
    _reload();
    _toast('${p.name} restocked');
  }

  Future<void> _delete(Product p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete product?'),
        content: Text('${p.name} will be removed from your catalog.'),
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
    await widget.repository.deleteProduct(p.id);
    _reload();
    _toast('${p.name} deleted');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _future,
      builder: (context, snap) {
        // Reload ke dauran purana data dikhate raho (filters reset na hon)
        if (snap.hasData) {
          return ProductsView(
            products: snap.data!,
            onAddProduct: () => _add(snap.data!),
            onRestock: _restock,
            onDelete: _delete,
          );
        }
        if (snap.hasError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Could not load products'),
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
