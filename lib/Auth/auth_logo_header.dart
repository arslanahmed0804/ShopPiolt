import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class AuthLogoHeader extends StatelessWidget {
  const AuthLogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.qr_code_scanner, color: AppColors.dark),
      ),
      const SizedBox(width: 12),
      const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Stockwise', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        Text('Smart inventory', style: TextStyle(color: AppColors.muted, fontSize: 13)),
      ]),
    ]);
  }
}