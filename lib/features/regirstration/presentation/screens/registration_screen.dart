import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:equifax_poc/features/regirstration/presentation/widgets/education_info_step.dart';
import 'package:equifax_poc/features/regirstration/presentation/widgets/personal_info_step.dart';
import 'package:equifax_poc/features/regirstration/presentation/widgets/registration_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(registrationControllerProvider);

    final controller = ref.read(registrationControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // =========================
            // TOP SECTION
            // =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                children: [
                  // Back + Step indicator
                  Row(
                    children: [
                      if (registrationState.currentStep > 0)
                        TextButton.icon(
                          onPressed: controller.previousStep,
                          icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                          label: const Text('Back'),
                        )
                      else
                        const SizedBox(width: 80),

                      const Spacer(),

                      Text(
                        'Step ${registrationState.currentStep + 1} of 5',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      const Spacer(),

                      // Keeps step text centered
                      const SizedBox(width: 80),
                    ],
                  ),

                  const SizedBox(height: 20),

                  RegistrationProgress(
                    currentStep: registrationState.currentStep,
                    totalSteps: 5,
                  ),
                ],
              ),
            ),

            // =========================
            // CURRENT STEP
            // =========================
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildCurrentStep(registrationState.currentStep),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStep(int step) {
    switch (step) {
      case 0:
        return const PersonalInfoStep(key: ValueKey('personal_info'));

      case 1:
        return const EducationInfoStep(key: ValueKey('education_info'));

      case 2:
        return const Center(key: ValueKey('step_3'), child: Text('Address'));

      case 3:
        return const Center(
          key: ValueKey('step_4'),
          child: Text('Login Credentials'),
        );

      case 4:
        return const Center(
          key: ValueKey('step_5'),
          child: Text('Review & Register'),
        );

      default:
        return const SizedBox();
    }
  }
}
