import 'package:flutter/material.dart';
import '../Core/theme/app_colors.dart';
import '../Core/widgets/app_card.dart';

class SmartLookupCard extends StatelessWidget {
  final VoidCallback onOpenScanner;
  const SmartLookupCard({super.key, required this.onOpenScanner});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.dark,
      bordered: false,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.qr_code_scanner, color: AppColors.dark, size: 28),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF34503F)),
              ),
              child: const Text('SMART LOOKUP',
                  style: TextStyle(color: AppColors.sidebarMuted, fontSize: 12, fontWeight: FontWeight.w600)),
            ),
          ]),
          const SizedBox(height: 28),
          const Text('Find any product, fast.',
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          const Text('Scan a barcode or use your camera to identify products from your catalog.',
              style: TextStyle(color: AppColors.sidebarMuted, fontSize: 17, height: 1.6)),
          const SizedBox(height: 28),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: onOpenScanner,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(children: [
                  Expanded(child: Text('Open smart scanner', style: TextStyle(fontSize: 18))),
                  Icon(Icons.arrow_forward, size: 20),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}