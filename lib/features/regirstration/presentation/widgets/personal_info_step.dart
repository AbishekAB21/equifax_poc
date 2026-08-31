import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/core/widgets/app_textfields.dart';
import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInfoStep extends ConsumerStatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  ConsumerState<PersonalInfoStep> createState() =>
      _PersonalInfoStepState();
}

class _PersonalInfoStepState extends ConsumerState<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _primaryPhoneController = TextEditingController();
  final _secondaryPhoneController = TextEditingController();

  String? _gender;

  @override
  void initState() {
    super.initState();

    final state = ref.read(registrationControllerProvider);

    _firstNameController.text = state.firstName;
    _lastNameController.text = state.lastName;
    _emailController.text = state.email;
    _dobController.text = state.dob;
    _primaryPhoneController.text = state.primaryPhone;
    _secondaryPhoneController.text = state.secondaryPhone;

    _gender = state.gender.isEmpty ? null : state.gender;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _primaryPhoneController.dispose();
    _secondaryPhoneController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(registrationControllerProvider.notifier)
        .updatePersonalInfo(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          gender: _gender!,
          dob: _dobController.text.trim(),
          primaryPhone: _primaryPhoneController.text.trim(),
          secondaryPhone: _secondaryPhoneController.text.trim(),
        );

    ref.read(registrationControllerProvider.notifier).nextStep();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: DateTime.now().subtract(
        const Duration(days: 365 * 18),
      ),
    );

    if (date != null) {
      _dobController.text =
          '${date.day}/${date.month}/${date.year}';
    }
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
                Icons.person_outline,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Your details',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Please tell us a little about yourself.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Text(
      'PERSONAL INFORMATION',
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
        AppTextField(
          controller: _firstNameController,
          label: 'First Name',
          icon: Icons.person_outline,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _lastNameController,
          label: 'Last Name',
          icon: Icons.person_outline,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _emailController,
          label: 'Email Address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty ||
                !value.contains('@')) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        _genderField(),

        const SizedBox(height: 16),

        AppTextField(
          controller: _dobController,
          label: 'Date of Birth',
          icon: Icons.calendar_today_outlined,
          readOnly: true,
          onTap: _selectDate,
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your date of birth';
            }
            return null;
          },
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _primaryPhoneController,
          label: 'Primary Phone Number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your primary phone number';
            }

            if (value.trim().length < 10) {
              return 'Please enter a valid phone number';
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _secondaryPhoneController,
          label: 'Secondary Phone Number (Optional)',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _genderField() {
    return DropdownButtonFormField<String>(
      initialValue: _gender,
      decoration: const InputDecoration(
        labelText: 'Gender',
        prefixIcon: Icon(Icons.person_outline),
      ),
      items: const [
        DropdownMenuItem(
          value: 'Male',
          child: Text('Male'),
        ),
        DropdownMenuItem(
          value: 'Female',
          child: Text('Female'),
        ),
        DropdownMenuItem(
          value: 'Other',
          child: Text('Other'),
        ),
      ],
      onChanged: (value) {
        setState(() => _gender = value);
      },
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
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