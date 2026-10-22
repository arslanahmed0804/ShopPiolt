import 'package:flutter/material.dart';
// import '../../Core/theme/app_colors.dart';
import '../../Home-Component/Core/theme/app_colors.dart';

class ProductsPagination extends StatelessWidget {
  final int page; // 0-based
  final int pageSize;
  final int total;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const ProductsPagination({
    super.key,
    required this.page,
    required this.pageSize,
    required this.total,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final start = total == 0 ? 0 : page * pageSize + 1;
    final end = ((page + 1) * pageSize).clamp(0, total);
    final hasPrev = page > 0;
    final hasNext = end < total;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(children: [
        Expanded(
          child: Text('Showing $start–$end of $total',
              style: const TextStyle(color: AppColors.muted, fontSize: 14)),
        ),
        _PageButton(icon: Icons.chevron_left, onTap: hasPrev ? onPrev : null),
        const SizedBox(width: 8),
        _PageButton(icon: Icons.chevron_right, onTap: hasNext ? onNext : null),
      ]),
    );
  }
}

class _PageButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _PageButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(icon, color: onTap == null ? AppColors.border : AppColors.ink),
        ),
      ),
    );
  }
}