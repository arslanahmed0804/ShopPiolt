import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../../Data/models/bill.dart';
import '../Bill/Data/bill.dart';

class PaymentMethodSelector extends StatelessWidget {
  final PaymentMethod selected;
  final ValueChanged<PaymentMethod> onChanged;
  const PaymentMethodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  static const _icons = {
    PaymentMethod.cash: Icons.payments_outlined,
    PaymentMethod.card: Icons.credit_card,
    PaymentMethod.credit: Icons.menu_book_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final m in PaymentMethod.values) ...[
          Expanded(
            child: _Option(
              icon: _icons[m]!,
              label: m.label,
              selected: m == selected,
              onTap: () => onChanged(m),
            ),
          ),
          if (m != PaymentMethod.values.last) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

class _Option extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Option({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = selected ? Colors.white : AppColors.ink;
    return Material(
      color: selected ? AppColors.dark : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.dark : AppColors.border,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? AppColors.lime : AppColors.muted,
                size: 22,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  color: fg,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
