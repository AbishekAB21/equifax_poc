import 'package:equifax_poc/core/constants/strings.dart';
import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReviewStep extends ConsumerWidget {
  const ReviewStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationControllerProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),

          const SizedBox(height: 28),

          _section(
            title: 'Personal Information',
            children: [
              _item('Name', '${state.firstName} ${state.lastName}'),
              _item('Email', state.email),
              _item('Gender', state.gender),
              _item('Date of Birth', state.dob),
              _item('Primary Phone', state.primaryPhone),
            ],
          ),

          _section(
            title: 'Education & Work',
            children: [
              _item('Highest Degree', state.highestDegree),
              _item('Institution', state.institution),
              _item('Passing Year', state.passYear),
              _item('Occupation', state.occupation),
              _item('Experience', '${state.experienceYears} years'),
            ],
          ),

          _section(
            title: 'Address',
            children: [
              _item('Address', state.streetAddress),
              _item('Landmark', state.landmark),
              _item('City', state.city),
              _item('State', state.state),
              _item('Postal Code', state.zipCode),
              _item('Country', state.country),
            ],
          ),

          _section(
            title: 'Login',
            children: [
              _item('Login ID', state.loginId),
              _item('Password', '••••••••'),
            ],
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  await ref
                      .read(registrationControllerProvider.notifier)
                      .register();

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(content: Text(AppStrings.registrationSuccess)),
                  );

                  await Future.delayed(const Duration(milliseconds: 500));

                  if (!context.mounted) return;

                  Navigator.of(context).popUntil((route) => route.isFirst);
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppStrings.registrationError)),
                  );
                }
              },
              icon: const Icon(Icons.check),
              label: const Text('Create Account'),
            ),
          ),
        ],
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
                Icons.fact_check_outlined,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            Text(
              'Review details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          'Make sure everything looks correct before creating your account.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 12),

          ...children,
        ],
      ),
    );
  }

  Widget _item(String label, String value) {
    if (value.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
