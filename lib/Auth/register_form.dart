import 'package:flutter/material.dart';
import '../Home-Component/Core/theme/app_colors.dart';
import '../Controller/auth_controller.dart';
import 'auth_error_banner.dart';
import 'auth_submit_button.dart';
import 'auth_switch_link.dart';
import 'auth_text_field.dart';
import 'validators.dart';

class RegisterForm extends StatefulWidget {
  final AuthController controller;
  final VoidCallback onSwitch;
  const RegisterForm({super.key, required this.controller, required this.onSwitch});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    // Register + auto-login. Success par AuthGate app screen dikha deta hai
    await widget.controller.register(_name.text, _email.text, _password.text);
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
              const Text('Create account',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -0.8)),
              const SizedBox(height: 8),
              const Text('Set up your Stockwise workspace in a minute.',
                  style: TextStyle(color: AppColors.muted, fontSize: 16)),
              const SizedBox(height: 28),
              AuthErrorBanner(message: widget.controller.error),
              AuthTextField(
                controller: _name,
                label: 'Full name',
                icon: Icons.person_outline,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                validator: Validators.name,
              ),
              const SizedBox(height: 14),
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
                label: 'Password (min 8 characters)',
                icon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                validator: Validators.password,
              ),
              const SizedBox(height: 14),
              AuthTextField(
                controller: _confirm,
                label: 'Confirm password',
                icon: Icons.lock_outline,
                isPassword: true,
                textInputAction: TextInputAction.done,
                validator: (v) => v == _password.text ? null : 'Passwords do not match',
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 24),
              AuthSubmitButton(label: 'Create account', busy: widget.controller.busy, onPressed: _submit),
              const SizedBox(height: 18),
              Center(
                child: AuthSwitchLink(
                  prompt: 'Already have an account?',
                  action: 'Log in',
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