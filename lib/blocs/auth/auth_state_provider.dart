import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/auth/auth_repo.dart';
import 'auth_state.dart';

final authProvider = StateNotifierProvider<AuthBloc, AuthState>((ref) {
  return AuthBloc(ref.read(authRepoProvider));
});

class AuthBloc extends StateNotifier<AuthState> {
  AuthBloc(this.authRepo) : super(AuthState.initial()) {
    fetchLoginInfo();
  }
  final AuthRepo authRepo;

  Future<void> loginWithGoogle() async {
    final response = await authRepo.loginWithGoogle();
    if (response.error != null) {
      Fluttertoast.showToast(msg: (response.error?.error ?? "-").toString());
    } else{
      state = state.copyWith(
        authenticated: true,
        authFetching: false,
        user: response.data,
      );
    }
  }

  Future<void> fetchLoginInfo() async {
    state = state.copyWith(authFetching: true);
    final userOrError = await authRepo.getCurrentUser();
    if (userOrError.data != null) {
      state = state.copyWith(
        authenticated: true,
        authFetching: false,
        user: userOrError.data,
      );
    } else {
      state = state.copyWith(
        authenticated: false,
        authFetching: false,
        user: null,
        errorMessage: ((userOrError.error?.error) ?? "-"),
      );
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    String phone = "+1${phoneNumber.replaceAll("-", "")}";
    if (phone != state.phoneNumber) {
      state = state.copyWith(
        phoneNumber: phone,
        isPhoneValid: phone.length == 11,
      );
    }
  }

  void updateCode(String code) {
    String verificationCode = code.replaceAll("-", "");
    if (verificationCode != state.verificationCode) {
      state = state.copyWith(
        verificationCode: verificationCode,
        isVerificationCodeValid: verificationCode.length == 4,
      );
    }
    if (verificationCode.length == 4) {
      verifyCode();
    }
  }

  void useEmailLogin({bool useEmail = false}) {
    state = state.copyWith(showEmailLogin: useEmail);
  }

  void updateEmail(String email) {
    String emailRegex = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    bool isEmailValid = RegExp(emailRegex).hasMatch(email);
    if (email != state.email) {
      state = state.copyWith(email: email, isEmailValid: isEmailValid);
    }
  }

  void updatePassword(String password) {
    if (password != state.password) {
      state = state.copyWith(password: password);
    }
  }

  Future<void> submitPhoneForVerification({bool isRetryCode = false}) async {
    state = state.copyWith(showProgress: true);
    final codeSent =
        await authRepo.submitPhoneForVerification(state.phoneNumber);
    final message =
        codeSent ? "" : "Unable to send code to ${state.phoneNumber}";
    state = state.copyWith(
        showCodeSent: codeSent, showProgress: false, errorMessage: message);
    if (codeSent) {
      state = state.copyWith(
          allowCodeEntry: codeSent,
          codeSentTimestamp: DateTime.now(),
          retryWaitTime: isRetryCode
              ? const Duration(seconds: 60)
              : const Duration(seconds: 10));
    }
  }

  Future<void> verifyCode() async {
    state = state.copyWith(showProgress: true);
    bool codeVerified = false;

    codeVerified =
        await authRepo.verifyCode(state.phoneNumber, state.verificationCode);
    state = state.copyWith(
      showProgress: false,
      showVerificationSuccess: codeVerified,
      errorMessage: "",
    );
    if (codeVerified) {
      await Future.delayed(const Duration(seconds: 1));
      state = state.copyWith(
        showVerificationSuccess: false,
        authenticated: true,
        authFetching: false,
      );
    } else {
      handleLoginException("--");
    }
  }

  Future<void> handleLoginException(String error) async {
    state = state.copyWith(
      showProgress: false,
      showVerificationSuccess: false,
      errorMessage: error,
    );
  }

  Future<void> loginWithEmail() async {
    state = state.copyWith(showProgress: true);

    final userOrError =
        await authRepo.loginWithEmailPassword(state.email, state.password);
    final isDataNull = userOrError.data == null;
    print("Hey");
    if (isDataNull) {
      handleLoginException(userOrError.error?.error ?? "");

      print("User updated");
    } else {
      state = state.copyWith(
        authenticated: true,
        authFetching: false,
        user: userOrError.data,
      );
    }
  }

  Future<void> logout() async {
    state = AuthState.initial();
    await authRepo.logout();
    state = AuthState.initial().copyWith(authFetching: false);
  }
}
