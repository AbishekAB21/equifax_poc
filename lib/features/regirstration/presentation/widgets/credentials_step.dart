import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/core/widgets/app_textfields.dart';
import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredentialsStep extends ConsumerStatefulWidget {
  const CredentialsStep({super.key});

  @override
  ConsumerState<CredentialsStep> createState() =>
      _CredentialsStepState();
}

class _CredentialsStepState extends ConsumerState<CredentialsStep> {
  final _formKey = GlobalKey<FormState>();

  final _loginIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    final state = ref.read(registrationControllerProvider);

    _loginIdController.text = state.loginId;
    _passwordController.text = state.password;
  }

  @override
  void dispose() {
    _loginIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(registrationControllerProvider.notifier)
        .updateCredentials(
          loginId: _loginIdController.text.trim(),
          password: _passwordController.text,
        );

    ref.read(registrationControllerProvider.notifier).nextStep();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),

            const SizedBox(height: 32),

            Text(
              'LOGIN DETAILS',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
            ),

            const SizedBox(height: 12),

            AppTextField(
              controller: _loginIdController,
              label: 'Login ID',
              icon: Icons.person_outline,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a login ID';
                }

                if (value.trim().length < 4) {
                  return 'Login ID must be at least 4 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            AppTextField(
              controller: _passwordController,
              label: 'Password',
              icon: Icons.lock_outline,
              textInputAction: TextInputAction.done,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }

                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }

                return null;
              },
            ),

            const SizedBox(height: 32),

            _continueButton(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.lock_outline,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            Text(
              'Create your account',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          'Choose your login credentials.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _continueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _saveAndContinue,
        iconAlignment: IconAlignment.end,
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Review details'),
      ),
    );
  }
}