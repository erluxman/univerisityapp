import 'package:university_app/data/auth/model/tyro_user.dart';

class AuthState {
  final String email;
  final String password;
  final String phoneNumber;
  final String verificationCode;
  final bool authenticated;
  final bool showProgress;
  final bool isPhoneValid;
  final bool isEmailValid;
  final bool authFetching;
  final bool showEmailLogin;
  final bool allowCodeEntry;
  final bool isVerificationCodeValid;
  final bool showCodeSent;
  final DateTime codeSentTimestamp;
  final Duration retryWaitTime;
  final String errorMessage;
  final bool showVerificationSuccess;
  final TyroUser? user;

  AuthState({
    required this.email,
    required this.password,
    required this.verificationCode,
    required this.phoneNumber,
    required this.isPhoneValid,
    required this.allowCodeEntry,
    required this.authenticated,
    required this.showProgress,
    required this.showCodeSent,
    required this.isEmailValid,
    required this.showEmailLogin,
    required this.codeSentTimestamp,
    required this.retryWaitTime,
    required this.isVerificationCodeValid,
    required this.errorMessage,
    required this.showVerificationSuccess,
    required this.authFetching,
    required this.user,
  });

  factory AuthState.initial() {
    return AuthState(
        email: '',
        password: '',
        phoneNumber: '',
        errorMessage: '',
        verificationCode: '',
        authenticated: false,
        showProgress: false,
        isPhoneValid: false,
        allowCodeEntry: false,
        isEmailValid: false,
        showEmailLogin: false,
        codeSentTimestamp: DateTime.now(),
        retryWaitTime: const Duration(seconds: 10),
        showVerificationSuccess: false,
        isVerificationCodeValid: false,
        showCodeSent: false,
        authFetching: true,
        user: null);
  }

  AuthState copyWith({
    String? email,
    String? password,
    String? phoneNumber,
    String? verificationCode,
    String? errorMessage,
    bool? authenticated,
    bool? showProgress,
    bool? allowCodeEntry,
    bool? authFetching,
    bool? showEmailLogin,
    bool? isPhoneValid,
    bool? isEmailValid,
    DateTime? codeSentTimestamp,
    Duration? retryWaitTime,
    bool? showVerificationSuccess,
    bool? isVerificationCodeValid,
    bool? showCodeSent,
    TyroUser? user,
  }) {
    return AuthState(
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authenticated: authenticated ?? this.authenticated,
      errorMessage: errorMessage ?? this.errorMessage,
      showProgress: showProgress ?? this.showProgress,
      showEmailLogin: showEmailLogin ?? this.showEmailLogin,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      authFetching: authFetching ?? this.authFetching,
      retryWaitTime: retryWaitTime ?? this.retryWaitTime,
      codeSentTimestamp: codeSentTimestamp ?? this.codeSentTimestamp,
      isVerificationCodeValid:
          isVerificationCodeValid ?? this.isVerificationCodeValid,
      allowCodeEntry: allowCodeEntry ?? this.allowCodeEntry,
      user: user ?? this.user,
      showCodeSent: showCodeSent ?? this.showCodeSent,
      showVerificationSuccess:
          showVerificationSuccess ?? this.showVerificationSuccess,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
    );
  }
}
