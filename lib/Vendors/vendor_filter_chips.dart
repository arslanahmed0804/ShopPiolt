import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../Home-Component/Core/theme/app_colors.dart';

enum VendorFilter { all, active, inactive }

class VendorFilterChips extends StatelessWidget {
  final VendorFilter selected;
  final Map<VendorFilter, int> counts;
  final ValueChanged<VendorFilter> onChanged;

  const VendorFilterChips({
    super.key,
    required this.selected,
    required this.counts,
    required this.onChanged,
  });

  static const _labels = {
    VendorFilter.all: 'All',
    VendorFilter.active: 'Active',
    VendorFilter.inactive: 'Inactive',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 10, runSpacing: 10, children: [
      for (final f in VendorFilter.values)
        _Chip(
          label: _labels[f]!,
          count: counts[f] ?? 0,
          selected: f == selected,
          onTap: () => onChanged(f),
        ),
    ]);
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.count, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.dark : Colors.white,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: selected ? AppColors.dark : AppColors.border),
          ),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: label,
              style: TextStyle(
                  color: selected ? Colors.white : AppColors.ink, fontWeight: FontWeight.w600, fontSize: 15),
            ),
            TextSpan(
              text: '  $count',
              style: TextStyle(color: selected ? AppColors.lime : AppColors.muted, fontSize: 15),
            ),
          ])),
        ),
      ),
    );
  }
}