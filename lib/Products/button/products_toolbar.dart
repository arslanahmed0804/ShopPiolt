import 'package:flutter/material.dart';
// import '../../Core/widgets/search_field.dart';
import '../../Home-Component/Core/widgets/search_field.dart';
// import 'category_dropdown.dart';
import '../dropdown/category_dropdown.dart';

class ProductsToolbar extends StatelessWidget {
  final List<String> categories;
  final String? category;
  final ValueChanged<String> onSearch;
  final ValueChanged<String?> onCategory;

  const ProductsToolbar({
    super.key,
    required this.categories,
    required this.category,
    required this.onSearch,
    required this.onCategory,
  });

  @override
  Widget build(BuildContext context) {
    final search = AppSearchField(
      hint: 'Search by name or SKU…',
      onChanged: onSearch,
    );
    final dropdown = CategoryDropdown(
      categories: categories,
      value: category,
      onChanged: onCategory,
    );
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 600) {
          return Column(
            children: [search, const SizedBox(height: 12), dropdown],
          );
        }
        return Row(
          children: [
            Expanded(child: search),
            const SizedBox(width: 16),
            SizedBox(width: 240, child: dropdown),
          ],
        );
      },
    );
  }
}
