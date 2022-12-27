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
    } else {
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

  Future<void> handleLoginException(String error) async {
    state = state.copyWith(
      showProgress: false,
      showVerificationSuccess: false,
      errorMessage: error,
    );
  }

  Future<void> logout() async {
    state = AuthState.initial();
    await authRepo.logout();
    state = AuthState.initial().copyWith(authFetching: false);
  }

  void updateName(String value) {
    final newUser = state.user?.copyWith(name: value);
    authRepo.updateUserField(field: "fullName", value: value);
    state = state.copyWith(user: newUser);
  }
}
