import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

class AuthSwitchLink extends StatelessWidget {
  final String prompt;
  final String action;
  final VoidCallback onTap;
  const AuthSwitchLink({super.key, required this.prompt, required this.action, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: const TextStyle(color: AppColors.muted, fontSize: 15)),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(foregroundColor: AppColors.sidebar),
          child: Text(action, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}