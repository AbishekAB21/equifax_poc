import 'package:equifax_poc/core/theme/app_color.dart';
import 'package:equifax_poc/core/widgets/app_textfields.dart';
import 'package:equifax_poc/features/regirstration/presentation/controllers/registration_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressInfoStep extends ConsumerStatefulWidget {
  const AddressInfoStep({super.key});

  @override
  ConsumerState<AddressInfoStep> createState() =>
      _AddressInfoStepState();
}

class _AddressInfoStepState extends ConsumerState<AddressInfoStep> {
  final _formKey = GlobalKey<FormState>();

  final _streetController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = ref.read(registrationControllerProvider);

    _streetController.text = state.streetAddress;
    _landmarkController.text = state.landmark;
    _cityController.text = state.city;
    _stateController.text = state.state;
    _zipController.text = state.zipCode;
  }

  @override
  void dispose() {
    _streetController.dispose();
    _landmarkController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _saveAndContinue() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(registrationControllerProvider.notifier)
        .updateAddressInfo(
          streetAddress: _streetController.text.trim(),
          landmark: _landmarkController.text.trim(),
          city: _cityController.text.trim(),
          stateName: _stateController.text.trim(),
          zipCode: _zipController.text.trim(),
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
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Your address',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Tell us where you currently live.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _sectionTitle(BuildContext context) {
    return Text(
      'ADDRESS INFORMATION',
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
          controller: _streetController,
          label: 'Street Address',
          icon: Icons.home_outlined,
          textInputAction: TextInputAction.next,
          validator: _required('Please enter your street address'),
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _landmarkController,
          label: 'Landmark (Optional)',
          icon: Icons.place_outlined,
          textInputAction: TextInputAction.next,
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _cityController,
          label: 'City',
          icon: Icons.location_city_outlined,
          textInputAction: TextInputAction.next,
          validator: _required('Please enter your city'),
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _stateController,
          label: 'State',
          icon: Icons.map_outlined,
          textInputAction: TextInputAction.next,
          validator: _required('Please enter your state'),
        ),

        const SizedBox(height: 16),

        AppTextField(
          controller: _zipController,
          label: 'ZIP / Postal Code',
          icon: Icons.markunread_mailbox_outlined,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter your postal code';
            }

            if (value.trim().length < 4) {
              return 'Please enter a valid postal code';
            }

            return null;
          },
        ),
      ],
    );
  }

  String? Function(String?) _required(String message) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return message;
      }
      return null;
    };
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