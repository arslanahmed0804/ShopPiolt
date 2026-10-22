import 'package:flutter/material.dart';
import '../Core/widgets/page_container.dart';
import '../../../Home-Component/Core/Data/models/product.dart';

// import '../Data/models/product.dart';
// import 'widgets/products_empty_state.dart';
import '../../Products/low/products_empty_state.dart';
// import 'widgets/products_header.dart';
import '../restock/widgets/products_header.dart';
// import 'widgets/products_list.dart';
import '../low/products_list.dart';
// import 'widgets/products_pagination.dart';
import '../low/products_pagination.dart';
// import 'widgets/products_table.dart';
import '../low/products_table.dart';
// import 'widgets/products_toolbar.dart';
import '../button/products_toolbar.dart';
// import 'widgets/stock_status_chips.dart';
import '../dropdown/stock_status_chips.dart';

/// Filters + pagination ka local state yahan hai.
/// Backend aane par search/filter server-side bhi kar sakte ho.
class ProductsView extends StatefulWidget {
  final List<Product> products;
  final VoidCallback onAddProduct;
  final ValueChanged<Product> onRestock;
  final ValueChanged<Product> onDelete;

  const ProductsView({
    super.key,
    required this.products,
    required this.onAddProduct,
    required this.onRestock,
    required this.onDelete,
  });

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  static const _pageSize = 8;
  String _query = '';
  String? _category;
  StockStatus? _status;
  int _page = 0;

  List<String> get _categories =>
      (widget.products.map((p) => p.category).toSet().toList()..sort());

  /// Search + category filter (status ke bina) - chips ke counts ke liye
  List<Product> get _base {
    final q = _query.trim().toLowerCase();
    return widget.products.where((p) {
      if (_category != null && p.category != _category) return false;
      if (q.isEmpty) return true;
      return p.name.toLowerCase().contains(q) ||
          p.sku.toLowerCase().contains(q);
    }).toList();
  }

  void _clear() => setState(() {
    _query = '';
    _category = null;
    _status = null;
    _page = 0;
  });

  @override
  Widget build(BuildContext context) {
    final base = _base;
    final filtered = _status == null
        ? base
        : base.where((p) => p.status == _status).toList();

    final counts = <StockStatus?, int>{
      null: base.length,
      for (final s in StockStatus.values)
        s: base.where((p) => p.status == s).length,
    };

    final pages = (filtered.length / _pageSize).ceil().clamp(1, 1 << 30);
    final page = _page.clamp(0, pages - 1);
    final slice = filtered.skip(page * _pageSize).take(_pageSize).toList();

    final footer = ProductsPagination(
      page: page,
      pageSize: _pageSize,
      total: filtered.length,
      onPrev: () => setState(() => _page = page - 1),
      onNext: () => setState(() => _page = page + 1),
    );

    return PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductsHeader(
            count: widget.products.length,
            onAddProduct: widget.onAddProduct,
          ),
          const SizedBox(height: 28),
          ProductsToolbar(
            categories: _categories,
            category: _category,
            onSearch: (v) => setState(() {
              _query = v;
              _page = 0;
            }),
            onCategory: (v) => setState(() {
              _category = v;
              _page = 0;
            }),
          ),
          const SizedBox(height: 16),
          StockStatusChips(
            selected: _status,
            counts: counts,
            onChanged: (s) => setState(() {
              _status = s;
              _page = 0;
            }),
          ),
          const SizedBox(height: 20),
          if (filtered.isEmpty)
            ProductsEmptyState(onClear: _clear)
          else
            LayoutBuilder(
              builder: (context, c) {
                return c.maxWidth >= 820
                    ? ProductsTable(
                        products: slice,
                        footer: footer,
                        onRestock: widget.onRestock,
                        onDelete: widget.onDelete,
                      )
                    : ProductsList(
                        products: slice,
                        footer: footer,
                        onRestock: widget.onRestock,
                        onDelete: widget.onDelete,
                      );
              },
            ),
        ],
      ),
    );
  }
}
