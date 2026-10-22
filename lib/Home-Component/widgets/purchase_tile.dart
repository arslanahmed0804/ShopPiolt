import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/utils/format.dart';
import '../Core/Data/models/purchase.dart';
import '../Core/widgets/initials_avatar.dart';

class PurchaseTile extends StatelessWidget {
  final Purchase purchase;
  const PurchaseTile({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(children: [
        InitialsAvatar(
            text: purchase.initials, bg: const Color(0xFFEDEDE8), fg: AppColors.ink, circle: true),
        const SizedBox(width: 16),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(purchase.vendor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Text('${purchase.items} items · ${purchase.dateLabel}',
                style: const TextStyle(color: AppColors.muted, fontSize: 14)),
          ]),
        ),
        const SizedBox(width: 12),
        Text(formatRs(purchase.amount), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}