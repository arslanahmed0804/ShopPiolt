import 'package:flutter/material.dart';
// import '../Core/theme/app_colors.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../Data/models/auth_user.dart';
import '../models/auth_user.dart';
// import 'auth_controller.dart';
import '../Controller/auth_controller.dart';
import 'auth_page.dart';

/// Logged in ho to app dikhao, warna login/register page.
class AuthGate extends StatelessWidget {
  final AuthController controller;
  final Widget Function(BuildContext context, AuthUser user) signedInBuilder;

  const AuthGate({
    super.key,
    required this.controller,
    required this.signedInBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (controller.initializing) return const _Splash();
        final user = controller.user;
        if (user == null) return AuthPage(controller: controller);
        return signedInBuilder(context, user);
      },
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sidebar,
      body: Center(
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.lime,
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Icon(
            Icons.qr_code_scanner,
            color: AppColors.dark,
            size: 34,
          ),
        ),
      ),
    );
  }
}
