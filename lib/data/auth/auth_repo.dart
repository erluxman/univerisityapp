import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/data/data_or_error.dart';
import 'auth_datasource.dart';
import 'model/tyro_user.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo());

class AuthRepo {
  AuthRepo() {
    _dataSource = AuthDataSource();
  }

  late AuthDataSource _dataSource;

  Future<DataOrError<TyroUser>> getCurrentUser() async {
    return await _dataSource.getCurrentUser();
  }

  Future<bool> submitPhoneForVerification(String phoneNumber) {
    return _dataSource.submitPhoneForVerification(phoneNumber);
  }

  Future<bool> verifyCode(String phoneNumber, String verificationCode) {
    return _dataSource.verifyCode(phoneNumber, verificationCode);
  }

  Future<void> logout() async => _dataSource.logout();

  Future<DataOrError<TyroUser>> loginWithEmailPassword(
      String email, String password) async {
    return _dataSource.loginWithEmailPassword(email, password);
  }

  Future<DataOrError<TyroUser>> loginWithGoogle() async {
    return _dataSource.loginWithGoogle();
  }
}
