class RegistrationState {
  final int currentStep;

  // Step 1 - Personal
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dob;
  final String primaryPhone;
  final String secondaryPhone;

  // Step 2 - Education
  final String highestDegree;
  final String institution;
  final String passYear;
  final String occupation;
  final String experienceYears;

  // Step 3 - Address
  final String streetAddress;
  final String landmark;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  // Step 4 - Credentials
  final String loginId;
  final String password;

  const RegistrationState({
    this.currentStep = 0,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.gender = '',
    this.dob = '',
    this.primaryPhone = '',
    this.secondaryPhone = '',
    this.highestDegree = '',
    this.institution = '',
    this.passYear = '',
    this.occupation = '',
    this.experienceYears = '',
    this.streetAddress = '',
    this.landmark = '',
    this.city = '',
    this.state = '',
    this.zipCode = '',
    this.country = 'India',
    this.loginId = '',
    this.password = '',
  });

  RegistrationState copyWith({
    int? currentStep,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? dob,
    String? primaryPhone,
    String? secondaryPhone,
    String? highestDegree,
    String? institution,
    String? passYear,
    String? occupation,
    String? experienceYears,
    String? streetAddress,
    String? landmark,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? loginId,
    String? password,
  }) {
    return RegistrationState(
      currentStep: currentStep ?? this.currentStep,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      primaryPhone: primaryPhone ?? this.primaryPhone,
      secondaryPhone: secondaryPhone ?? this.secondaryPhone,
      highestDegree: highestDegree ?? this.highestDegree,
      institution: institution ?? this.institution,
      passYear: passYear ?? this.passYear,
      occupation: occupation ?? this.occupation,
      experienceYears: experienceYears ?? this.experienceYears,
      streetAddress: streetAddress ?? this.streetAddress,
      landmark: landmark ?? this.landmark,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      loginId: loginId ?? this.loginId,
      password: password ?? this.password,
    );
  }
}