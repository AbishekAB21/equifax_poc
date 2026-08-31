import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class RegistrationProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegistrationProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isActive = index <= currentStep;

        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(
              right: index == totalSteps - 1 ? 0 : 8,
            ),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.border,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }
}