class UserProfileEntity {
  final String id;

  // Personal Information
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String dob;
  final String primaryPhone;
  final String secondaryPhone;

  // Education & Work
  final String highestDegree;
  final String institution;
  final String passYear;
  final String occupation;
  final String experienceYears;

  // Address
  final String streetAddress;
  final String landmark;
  final String city;
  final String state;
  final String zipCode;
  final String country;

  // Account Credentials
  final String loginId;
  final String password;

  const UserProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.dob,
    required this.primaryPhone,
    required this.secondaryPhone,
    required this.highestDegree,
    required this.institution,
    required this.passYear,
    required this.occupation,
    required this.experienceYears,
    required this.streetAddress,
    required this.landmark,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.loginId,
    required this.password,
  });

  String get fullName => '$firstName $lastName'.trim();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'gender': gender,
      'dob': dob,
      'primaryPhone': primaryPhone,
      'secondaryPhone': secondaryPhone,
      'highestDegree': highestDegree,
      'institution': institution,
      'passYear': passYear,
      'occupation': occupation,
      'experienceYears': experienceYears,
      'streetAddress': streetAddress,
      'landmark': landmark,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'loginId': loginId,
      'password': password,
    };
  }

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) {
    return UserProfileEntity(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      gender: json['gender'] ?? '',
      dob: json['dob'] ?? '',
      primaryPhone: json['primaryPhone'] ?? '',
      secondaryPhone: json['secondaryPhone'] ?? '',
      highestDegree: json['highestDegree'] ?? '',
      institution: json['institution'] ?? '',
      passYear: json['passYear'] ?? '',
      occupation: json['occupation'] ?? '',
      experienceYears: json['experienceYears'] ?? '',
      streetAddress: json['streetAddress'] ?? '',
      landmark: json['landmark'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zipCode: json['zipCode'] ?? '',
      country: json['country'] ?? 'India',
      loginId: json['loginId'] ?? '',
      password: json['password'] ?? '',
    );
  }
}