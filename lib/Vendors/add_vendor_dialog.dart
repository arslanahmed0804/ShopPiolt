import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../../Data/models/vendor.dart';
import '../Vendors/Data/vendor.dart';

/// Naya vendor add karne ka form. Save par [Vendor] return karta hai.
class AddVendorDialog extends StatefulWidget {
  const AddVendorDialog({super.key});

  static Future<Vendor?> show(BuildContext context) {
    return showDialog<Vendor>(
      context: context,
      builder: (_) => const AddVendorDialog(),
    );
  }

  @override
  State<AddVendorDialog> createState() => _AddVendorDialogState();
}

class _AddVendorDialogState extends State<AddVendorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _city = TextEditingController();
  String _category = kVendorCategories.first;

  @override
  void dispose() {
    for (final c in [_name, _contact, _phone, _email, _city]) {
      c.dispose();
    }
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

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Required' : null;

  String? _optionalEmail(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    return v.contains('@') ? null : 'Invalid email';
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop(
      Vendor(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _name.text.trim(),
        contactPerson: _contact.text.trim(),
        phone: _phone.text.trim(),
        email: _email.text.trim(),
        city: _city.text.trim(),
        category: _category,
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
                        'Add vendor',
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
                TextFormField(
                  controller: _name,
                  decoration: _dec('Vendor / company name'),
                  validator: _required,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _contact,
                  decoration: _dec('Contact person'),
                  validator: _required,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phone,
                        decoration: _dec('Phone'),
                        keyboardType: TextInputType.phone,
                        validator: _required,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextFormField(
                        controller: _city,
                        decoration: _dec('City'),
                        validator: _required,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _email,
                  decoration: _dec('Email (optional)'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _optionalEmail,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  isExpanded: true,
                  decoration: _dec('Supplies'),
                  items: [
                    for (final c in kVendorCategories)
                      DropdownMenuItem(value: c, child: Text(c)),
                  ],
                  onChanged: (v) => setState(() => _category = v ?? _category),
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
                        'Save vendor',
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
