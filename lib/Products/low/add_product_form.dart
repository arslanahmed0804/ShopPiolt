// import 'package:flutter/material.dart';
// import '../../Home-Component/Core/theme/app_colors.dart';
// import '../../Home-Component/Core/Data/models/product.dart';

// /// Naya product add karne ka form. Save par [Product] return karta hai.
// class AddProductDialog extends StatefulWidget {
//   final List<String> categories;
//   const AddProductDialog({super.key, required this.categories});

//   static Future<Product?> show(BuildContext context, List<String> categories) {
//     return showDialog<Product>(
//       context: context,
//       builder: (_) => AddProductDialog(categories: categories),
//     );
//   }

//   @override
//   State<AddProductDialog> createState() => _AddProductDialogState();
// }

// class _AddProductDialogState extends State<AddProductDialog> {
//   final _formKey = GlobalKey<FormState>();
//   final _name = TextEditingController();
//   final _sku = TextEditingController();
//   final _price = TextEditingController();
//   final _qty = TextEditingController();
//   final _min = TextEditingController(text: '10');
//   late String _category = widget.categories.isNotEmpty ? widget.categories.first : 'General';

//   @override
//   void dispose() {
//     for (final c in [_name, _sku, _price, _qty, _min]) {
//       c.dispose();
//     }
//     super.dispose();
//   }

//   InputDecoration _dec(String label) {
//     OutlineInputBorder b(Color c) =>
//         OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: c));
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: AppColors.bg,
//       border: b(Colors.transparent),
//       enabledBorder: b(Colors.transparent),
//       focusedBorder: b(AppColors.sidebar),
//       errorBorder: b(AppColors.danger),
//       focusedErrorBorder: b(AppColors.danger),
//     );
//   }

//   String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

//   String? _number(String? v) {
//     if (v == null || v.trim().isEmpty) return 'Required';
//     return double.tryParse(v.trim()) == null ? 'Invalid number' : null;
//   }

//   void _save() {
//     if (!_formKey.currentState!.validate()) return;
//     final name = _name.text.trim();
//     final c = ProductPalette.pick(name);
//     Navigator.of(context).pop(Product(
//       id: DateTime.now().microsecondsSinceEpoch.toString(),
//       name: name,
//       sku: _sku.text.trim().toUpperCase(),
//       category: _category,
//       price: double.parse(_price.text.trim()),
//       quantity: double.parse(_qty.text.trim()).round(),
//       minQuantity: double.parse(_min.text.trim()).round(),
//       avatarBg: c[0],
//       avatarFg: c[1],
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cats = widget.categories.isEmpty ? ['General'] : widget.categories;
//     return Dialog(
//       backgroundColor: Colors.white,
//       insetPadding: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 520),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(28),
//           child: Form(
//             key: _formKey,
//             child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(children: [
//                 const Expanded(
//                   child: Text('Add product', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
//                 ),
//                 IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.close)),
//               ]),
//               const SizedBox(height: 20),
//               TextFormField(controller: _name, decoration: _dec('Product name'), validator: _required),
//               const SizedBox(height: 14),
//               Row(children: [
//                 Expanded(child: TextFormField(controller: _sku, decoration: _dec('SKU'), validator: _required)),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: DropdownButtonFormField<String>(
//                     initialValue: cats.contains(_category) ? _category : cats.first,
//                     isExpanded: true,
//                     decoration: _dec('Category'),
//                     items: [for (final c in cats) DropdownMenuItem(value: c, child: Text(c))],
//                     onChanged: (v) => setState(() => _category = v ?? _category),
//                   ),
//                 ),
//               ]),
//               const SizedBox(height: 14),
//               TextFormField(
//                 controller: _price,
//                 decoration: _dec('Price (Rs.)'),
//                 keyboardType: const TextInputType.numberWithOptions(decimal: true),
//                 validator: _number,
//               ),
//               const SizedBox(height: 14),
//               Row(children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _qty,
//                     decoration: _dec('Quantity'),
//                     keyboardType: TextInputType.number,
//                     validator: _number,
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(
//                   child: TextFormField(
//                     controller: _min,
//                     decoration: _dec('Min quantity'),
//                     keyboardType: TextInputType.number,
//                     validator: _number,
//                   ),
//                 ),
//               ]),
//               const SizedBox(height: 24),
//               Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                 OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
//                 const SizedBox(width: 12),
//                 FilledButton(
//                   onPressed: _save,
//                   style: FilledButton.styleFrom(
//                     backgroundColor: AppColors.dark,
//                     padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//                   ),
//                   child: const Text('Save product', style: TextStyle(fontSize: 16)),
//                 ),
//               ]),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Home-Component/Core/theme/app_colors.dart';
import '../../Home-Component/Core/Data/models/product.dart';

class AddProductDialog extends StatefulWidget {
  final List<String> vendors;

  const AddProductDialog({super.key, required this.vendors});

  static Future<Product?> show(BuildContext context, List<String> vendors) {
    return showDialog<Product>(
      context: context,
      builder: (_) => AddProductDialog(vendors: vendors),
    );
  }

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _barcode = TextEditingController();
  final _price = TextEditingController();
  final _min = TextEditingController(text: '10');

  String? _vendor;
  XFile? _selectedImage;

  @override
  void dispose() {
    _name.dispose();
    _barcode.dispose();
    _price.dispose();
    _min.dispose();
    super.dispose();
  }

  InputDecoration _dec(String label) {
    OutlineInputBorder b(Color c) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: c),
    );

    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: AppColors.bg,
      border: b(Colors.transparent),
      enabledBorder: b(Colors.transparent),
      focusedBorder: b(AppColors.sidebar),
      errorBorder: b(AppColors.danger),
      focusedErrorBorder: b(AppColors.danger),
    );
  }

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _number(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    final number = double.tryParse(value.trim());

    if (number == null || !number.isFinite || number < 0) {
      return 'Enter a valid amount';
    }

    return null;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _selectVendor() async {
    final searchController = TextEditingController();
    final vendors = widget.vendors.toSet().toList();

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final query = searchController.text.trim().toLowerCase();

            final filtered = vendors
                .where((vendor) => vendor.toLowerCase().contains(query))
                .toList();

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'Select vendor',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchController,
                      decoration: _dec(
                        'Search vendor',
                      ).copyWith(prefixIcon: const Icon(Icons.search)),
                      onChanged: (_) => setDialogState(() {}),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: filtered.isEmpty
                          ? const Center(child: Text('No vendors found'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final vendor = filtered[index];

                                return ListTile(
                                  dense: true,
                                  title: Text(vendor),
                                  trailing: _vendor == vendor
                                      ? Icon(
                                          Icons.check,
                                          color: AppColors.sidebar,
                                        )
                                      : null,
                                  onTap: () {
                                    Navigator.pop(dialogContext, vendor);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );

    searchController.dispose();

    if (selected != null && mounted) {
      setState(() => _vendor = selected);
    }
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    if (_vendor == null || !widget.vendors.contains(_vendor)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a vendor')));
      return;
    }

    final name = _name.text.trim();
    final colors = ProductPalette.pick(name);

    // Product model ko neeche di gayi fields ke mutabiq
    // update karna zaroori hai.
    Navigator.of(context).pop(
      Product(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        barcode: _barcode.text.trim(),
        vendorName: _vendor!,
        price: double.parse(_price.text.trim()),
        minQuantity: double.parse(_min.text.trim()).round(),
        imagePath: _selectedImage?.path,
        avatarBg: colors[0],
        avatarFg: colors[1],
        sku: '',
        quantity: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Add product',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Product image
                InkWell(
                  onTap: _pickImage,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: double.infinity,
                    height: 110,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: _selectedImage == null
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_photo_alternate_outlined),
                              SizedBox(width: 10),
                              Text('Add product image'),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              File(_selectedImage!.path),
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _name,
                  decoration: _dec('Product name'),
                  validator: _required,
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _barcode,
                        decoration: _dec('Barcode'),
                        validator: _required,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: InkWell(
                        onTap: _selectVendor,
                        borderRadius: BorderRadius.circular(16),
                        child: InputDecorator(
                          decoration: _dec('Vendor name'),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _vendor ?? 'Select vendor',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: _vendor == null
                                        ? Colors.black54
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _price,
                  decoration: _dec('Price (Rs.)'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: _number,
                ),

                const SizedBox(height: 14),

                TextFormField(
                  controller: _min,
                  decoration: _dec('Min quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final error = _number(value);
                    if (error != null) return error;

                    final parsed = double.parse(value!.trim());
                    if (parsed != parsed.roundToDouble()) {
                      return 'Enter a whole number';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.dark,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 26,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save product',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
