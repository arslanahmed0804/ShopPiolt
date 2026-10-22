import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Center(
        child: Text('$title — coming soon',
            style: const TextStyle(fontSize: 22, color: AppColors.muted)),
      );
}