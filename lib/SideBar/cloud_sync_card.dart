import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class CloudSyncCard extends StatelessWidget {
  final double progress;
  final String lastBackup;
  const CloudSyncCard({super.key, this.progress = 0.65, this.lastBackup = 'Last backup 2 minutes ago'});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF16302A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF24433A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Expanded(child: Text('Cloud sync', style: TextStyle(color: AppColors.sidebarMuted, fontSize: 15))),
            Icon(Icons.circle, size: 8, color: AppColors.lime),
            SizedBox(width: 6),
            Text('Synced', style: TextStyle(color: AppColors.lime, fontSize: 15)),
          ]),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              color: AppColors.lime,
              backgroundColor: const Color(0xFF2B4A40),
            ),
          ),
          const SizedBox(height: 12),
          Text(lastBackup, style: const TextStyle(color: AppColors.sidebarMuted, fontSize: 13)),
        ],
      ),
    );
  }
}