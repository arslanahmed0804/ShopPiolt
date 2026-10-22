import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';

/// Backend ka error message (jaise "Invalid email or password") yahan dikhta hai.
class AuthErrorBanner extends StatelessWidget {
  final String? message;
  const AuthErrorBanner({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.topCenter,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBE6DC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Icon(Icons.error_outline, color: AppColors.danger, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(message!, style: const TextStyle(color: AppColors.danger, fontSize: 14.5)),
                ),
              ]),
            ),
    );
  }
}