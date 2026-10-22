import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Home-Component/Core/widgets/app_card.dart';
// import 'auth_controller.dart';
import '../Controller/auth_controller.dart';
// import 'widgets/auth_brand_panel.dart';
import 'auth_brand_panel.dart';
import 'auth_logo_header.dart';
import 'login_form.dart';
// import 'lo'
import 'register_form.dart';

enum _AuthMode { login, register }

/// Responsive: wide screen par split (brand panel + form), mobile par sirf form.
class AuthPage extends StatefulWidget {
  final AuthController controller;
  const AuthPage({super.key, required this.controller});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  _AuthMode _mode = _AuthMode.login;

  void _switch(_AuthMode mode) {
    widget.controller.clearError();
    setState(() => _mode = mode);
  }

  @override
  Widget build(BuildContext context) {
    final form = AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _mode == _AuthMode.login
          ? LoginForm(
              key: const ValueKey('login'),
              controller: widget.controller,
              onSwitch: () => _switch(_AuthMode.register),
            )
          : RegisterForm(
              key: const ValueKey('register'),
              controller: widget.controller,
              onSwitch: () => _switch(_AuthMode.login),
            ),
    );

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: LayoutBuilder(
        builder: (context, c) {
          if (c.maxWidth >= 900) {
            return Row(
              children: [
                const Expanded(flex: 5, child: AuthBrandPanel()),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(40),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 440),
                        child: form,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AuthLogoHeader(),
                      const SizedBox(height: 24),
                      AppCard(padding: const EdgeInsets.all(24), child: form),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
