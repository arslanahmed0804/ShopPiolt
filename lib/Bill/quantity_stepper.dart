import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class QuantityStepper extends StatelessWidget {
  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  const QuantityStepper({super.key, required this.value, required this.max, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        _Btn(icon: Icons.remove, onTap: () => onChanged(value - 1)),
        SizedBox(
          width: 36,
          child: Center(child: Text('$value', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
        ),
        _Btn(icon: Icons.add, onTap: value < max ? () => onChanged(value + 1) : null),
      ]),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _Btn({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: SizedBox(
        width: 38,
        height: 40,
        child: Icon(icon, size: 18, color: onTap == null ? AppColors.border : AppColors.ink),
      ),
    );
  }
}