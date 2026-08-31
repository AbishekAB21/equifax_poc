import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/core/widgets/app_textfields.dart';
import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EducationInfoStep extends ConsumerStatefulWidget {
  const EducationInfoStep({super.key});

  @override
  ConsumerState<EducationInfoStep> createState() =>
      _EducationInfoStepState();
}

class _EducationInfoStepState
    extends ConsumerState<EducationInfoStep> {
  final _formKey = GlobalKey<FormState>();

  final _institutionController = TextEditingController();
  final _passYearController = TextEditingController();
  final _occupationController = TextEditingController();
  final _experienceController = TextEditingController();

  String? _highestDegree;

  @override
  void initState() {
    super.initState();

    final state = ref.read(registrationControllerProvider);

    _institutionController.text = state.institution;
    _passYearController.text = state.passYear;
    _occupationController.text = state.occupation;
    _experienceController.text = state.experienceYears;

    _highestDegree =
        state.highestDegree.isEmpty ? null : state.highestDegree;
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _passYearController.dispose();
    _occupationController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(registrationControllerProvider.notifier)
        .updateEducationInfo(
          highestDegree: _highestDegree!,
          institution: _institutionController.text.trim(),
          passYear: _passYearController.text.trim(),
          occupation: _occupationController.text.trim(),
          experienceYears: _experienceController.text.trim(),
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

            _sectionTitle(context),

            const SizedBox(height: 12),

            _buildForm(),

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
                border: Border.all(
                  color: AppColors.primary,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.school_outlined,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(width: 12),

            Text(
              'Education & work',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          'Tell us about your education and professional background.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Text(
      'EDUCATION & EMPLOYMENT',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        _degreeField(),

        const SizedBox(height: 16),

        AppTextField(
          controller: _institutionController,
          label: 'Institution',
          icon: Icons.account_balance_outlined,
          textInputAction: TextInputAction.next,
          validator: _requiredValidator('Please enter your institution'),
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _passYearController,
          label: 'Year of Passing',
          icon: Icons.calendar_today_outlined,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          validator: _yearValidator,
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _occupationController,
          label: 'Current Occupation',
          icon: Icons.work_outline,
          textInputAction: TextInputAction.next,
          validator: _requiredValidator('Please enter your occupation'),
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _experienceController,
          label: 'Years of Experience',
          icon: Icons.timeline_outlined,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          validator: _experienceValidator,
        ),
      ],
    );
  }

  Widget _degreeField() {
    return DropdownButtonFormField<String>(
      initialValue: _highestDegree,
      decoration: const InputDecoration(
        labelText: 'Highest Degree',
        prefixIcon: Icon(Icons.school_outlined),
      ),
      items: const [
        DropdownMenuItem(
          value: 'High School',
          child: Text('High School'),
        ),
        DropdownMenuItem(
          value: 'Diploma',
          child: Text('Diploma'),
        ),
        DropdownMenuItem(
          value: 'Bachelor’s Degree',
          child: Text('Bachelor’s Degree'),
        ),
        DropdownMenuItem(
          value: 'Master’s Degree',
          child: Text('Master’s Degree'),
        ),
        DropdownMenuItem(
          value: 'Doctorate',
          child: Text('Doctorate'),
        ),
        DropdownMenuItem(
          value: 'Other',
          child: Text('Other'),
        ),
      ],
      onChanged: (value) {
        setState(() {
          _highestDegree = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select your highest degree';
        }

        return null;
      },
    );
  }

  String? Function(String?) _requiredValidator(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }

      return null;
    };
  }

  String? _yearValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your passing year';
    }

    final year = int.tryParse(value);

    if (year == null ||
        year < 1900 ||
        year > DateTime.now().year) {
      return 'Please enter a valid year';
    }

    return null;
  }

  String? _experienceValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your experience';
    }

    final years = int.tryParse(value);

    if (years == null || years < 0) {
      return 'Please enter a valid number';
    }

    return null;
  }

  Widget _continueButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _saveAndContinue,
        iconAlignment: IconAlignment.end,
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Continue'),
      ),
    );
  }
}