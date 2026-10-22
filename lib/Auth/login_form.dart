import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
// import '../auth_controller.dart';
import '../Controller/auth_controller.dart';
import 'auth_error_banner.dart';
import 'auth_submit_button.dart';
import 'auth_switch_link.dart';
import 'auth_text_field.dart';
import 'validators.dart';

class LoginForm extends StatefulWidget {
  final AuthController controller;
  final VoidCallback onSwitch;
  const LoginForm({
    super.key,
    required this.controller,
    required this.onSwitch,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    // Success par AuthGate khud app screen dikha deta hai
    await widget.controller.login(_email.text, _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: ListenableBuilder(
          listenable: widget.controller,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Log in to manage your inventory.',
                style: TextStyle(color: AppColors.muted, fontSize: 16),
              ),
              const SizedBox(height: 28),
              AuthErrorBanner(message: widget.controller.error),
              AuthTextField(
                controller: _email,
                label: 'Email',
                icon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _password,
                label: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                validator: Validators.passwordRequired,
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 24),
              AuthSubmitButton(
                label: 'Log in',
                busy: widget.controller.busy,
                onPressed: _submit,
              ),
              const SizedBox(height: 18),
              Center(
                child: AuthSwitchLink(
                  prompt: "Don't have an account?",
                  action: 'Create one',
                  onTap: widget.onSwitch,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
