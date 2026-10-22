import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

/// Wide screens par left side ka dark branding panel.
class AuthBrandPanel extends StatelessWidget {
  const AuthBrandPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.sidebar,
      padding: const EdgeInsets.all(56),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.qr_code_scanner, color: AppColors.dark),
          ),
          const SizedBox(width: 14),
          const Text('Stockwise',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
        ]),
        const Spacer(),
        const Text('Run your inventory\nwithout the guesswork.',
            style: TextStyle(
                color: Colors.white, fontSize: 44, fontWeight: FontWeight.w800, height: 1.1, letterSpacing: -1.2)),
        const SizedBox(height: 20),
        const Text('Track stock, vendors and bills in one clean workspace.',
            style: TextStyle(color: AppColors.sidebarMuted, fontSize: 18, height: 1.5)),
        const SizedBox(height: 36),
        const _Point('Scan a barcode to find any product'),
        const _Point('Low-stock alerts before you run out'),
        const _Point('Bills and vendors, always in sync'),
        const Spacer(),
      ]),
    );
  }
}

class _Point extends StatelessWidget {
  final String text;
  const _Point(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(children: [
        Container(
          width: 26,
          height: 26,
          decoration: const BoxDecoration(color: Color(0xFF1F3D33), shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 16, color: AppColors.lime),
        ),
        const SizedBox(width: 14),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 16))),
      ]),
    );
  }
}