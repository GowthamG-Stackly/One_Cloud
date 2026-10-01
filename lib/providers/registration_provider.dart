import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationState {
  final int currentStep;

  // Organization
  final String organizationName;
  final String organizationCode;
  final String organizationType;
  final String industry;
  final String companySize;
  final String country;
  final String state;
  final String city;
  final String timeZone;
  final String organizationLogo;

  // Admin account
  final String firstName;
  final String lastName;
  final String adminEmail;
  final String mobileNumber;
  final String username;
  final String password;
  final String confirmPassword;

  // Terms
  final bool termsAccepted;
  final bool authorizationAccepted;
  final bool dataProcessingAccepted;
  final bool productUpdates;

  // UI state
  final bool isLoading;
  final bool registrationCompleted;

  const RegistrationState({
    this.currentStep = 1,
    this.organizationName = '',
    this.organizationCode = '',
    this.organizationType = 'Enterprise',
    this.industry = 'Information Technology',
    this.companySize = '501–1000',
    this.country = 'India',
    this.state = 'Telangana',
    this.city = '',
    this.timeZone = 'Asia/Kolkata (UTC +05:30)',
    this.organizationLogo = '',
    this.firstName = '',
    this.lastName = '',
    this.adminEmail = '',
    this.mobileNumber = '',
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
    this.termsAccepted = false,
    this.authorizationAccepted = false,
    this.dataProcessingAccepted = false,
    this.productUpdates = true,
    this.isLoading = false,
    this.registrationCompleted = false,
  });

  RegistrationState copyWith({
    int? currentStep,
    String? organizationName,
    String? organizationCode,
    String? organizationType,
    String? industry,
    String? companySize,
    String? country,
    String? state,
    String? city,
    String? timeZone,
    String? organizationLogo,
    String? firstName,
    String? lastName,
    String? adminEmail,
    String? mobileNumber,
    String? username,
    String? password,
    String? confirmPassword,
    bool? termsAccepted,
    bool? authorizationAccepted,
    bool? dataProcessingAccepted,
    bool? productUpdates,
    bool? isLoading,
    bool? registrationCompleted,
  }) {
    return RegistrationState(
      currentStep: currentStep ?? this.currentStep,
      organizationName: organizationName ?? this.organizationName,
      organizationCode: organizationCode ?? this.organizationCode,
      organizationType: organizationType ?? this.organizationType,
      industry: industry ?? this.industry,
      companySize: companySize ?? this.companySize,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      timeZone: timeZone ?? this.timeZone,
      organizationLogo: organizationLogo ?? this.organizationLogo,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      adminEmail: adminEmail ?? this.adminEmail,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      authorizationAccepted:
          authorizationAccepted ?? this.authorizationAccepted,
      dataProcessingAccepted:
          dataProcessingAccepted ?? this.dataProcessingAccepted,
      productUpdates: productUpdates ?? this.productUpdates,
      isLoading: isLoading ?? this.isLoading,
      registrationCompleted:
          registrationCompleted ?? this.registrationCompleted,
    );
  }
}

class RegistrationNotifier extends Notifier<RegistrationState> {
  @override
  RegistrationState build() => const RegistrationState();

  void setStep(int value) => state = state.copyWith(currentStep: value);

  void nextStep() {
    if (state.currentStep < 3) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setOrganizationName(String value) =>
      state = state.copyWith(organizationName: value);
  void setOrganizationCode(String value) =>
      state = state.copyWith(organizationCode: value);
  void setOrganizationType(String value) =>
      state = state.copyWith(organizationType: value);
  void setIndustry(String value) => state = state.copyWith(industry: value);
  void setCompanySize(String value) =>
      state = state.copyWith(companySize: value);
  void setCountry(String value) => state = state.copyWith(country: value);
  void setState(String value) => state = state.copyWith(state: value);
  void setCity(String value) => state = state.copyWith(city: value);
  void setTimeZone(String value) => state = state.copyWith(timeZone: value);
  void setOrganizationLogo(String value) =>
      state = state.copyWith(organizationLogo: value);

  void setFirstName(String value) => state = state.copyWith(firstName: value);
  void setLastName(String value) => state = state.copyWith(lastName: value);
  void setAdminEmail(String value) => state = state.copyWith(adminEmail: value);
  void setMobileNumber(String value) =>
      state = state.copyWith(mobileNumber: value);
  void setUsername(String value) => state = state.copyWith(username: value);
  void setPassword(String value) => state = state.copyWith(password: value);
  void setConfirmPassword(String value) =>
      state = state.copyWith(confirmPassword: value);

  void setTermsAccepted(bool value) =>
      state = state.copyWith(termsAccepted: value);
  void setAuthorizationAccepted(bool value) =>
      state = state.copyWith(authorizationAccepted: value);
  void setDataProcessingAccepted(bool value) =>
      state = state.copyWith(dataProcessingAccepted: value);
  void setProductUpdates(bool value) =>
      state = state.copyWith(productUpdates: value);

  void setLoading(bool value) => state = state.copyWith(isLoading: value);
  void setRegistrationCompleted(bool value) =>
      state = state.copyWith(registrationCompleted: value);

  void reset() => state = const RegistrationState();
}

final registrationProvider =
    NotifierProvider<RegistrationNotifier, RegistrationState>(
      RegistrationNotifier.new,
    );
