import 'package:equifax_poc/features/auth/domain/entities/user_profile_entity.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/auth_provider.dart';
import 'package:equifax_poc/features/auth/presentation/controllers/registration_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final registrationControllerProvider =
    NotifierProvider<RegistrationController, RegistrationState>(
  RegistrationController.new,
);

class RegistrationController extends Notifier<RegistrationState> {
  @override
  RegistrationState build() {
    return const RegistrationState();
  }

  void updatePersonalInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String gender,
    required String dob,
    required String primaryPhone,
    required String secondaryPhone,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      dob: dob,
      primaryPhone: primaryPhone,
      secondaryPhone: secondaryPhone,
    );
  }

  void updateEducationInfo({
    required String highestDegree,
    required String institution,
    required String passYear,
    required String occupation,
    required String experienceYears,
  }) {
    state = state.copyWith(
      highestDegree: highestDegree,
      institution: institution,
      passYear: passYear,
      occupation: occupation,
      experienceYears: experienceYears,
    );
  }

  void updateAddressInfo({
    required String streetAddress,
    required String landmark,
    required String city,
    required String stateName,
    required String zipCode,
  }) {
    state = state.copyWith(
      streetAddress: streetAddress,
      landmark: landmark,
      city: city,
      state: stateName,
      zipCode: zipCode,
    );
  }

  void updateCredentials({
    required String loginId,
    required String password,
  }) {
    state = state.copyWith(
      loginId: loginId,
      password: password,
    );
  }

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(
        currentStep: state.currentStep + 1,
      );
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(
        currentStep: state.currentStep - 1,
      );
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 4) {
      state = state.copyWith(currentStep: step);
    }
  }

  Future<void> register() async {
    final user = UserProfileEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: state.firstName,
      lastName: state.lastName,
      email: state.email,
      gender: state.gender,
      dob: state.dob,
      primaryPhone: state.primaryPhone,
      secondaryPhone: state.secondaryPhone,
      highestDegree: state.highestDegree,
      institution: state.institution,
      passYear: state.passYear,
      occupation: state.occupation,
      experienceYears: state.experienceYears,
      streetAddress: state.streetAddress,
      landmark: state.landmark,
      city: state.city,
      state: state.state,
      zipCode: state.zipCode,
      country: state.country,
      loginId: state.loginId,
      password: state.password,
    );

    final repository = ref.read(authRepositoryProvider);

    await repository.register(user);
  }
}