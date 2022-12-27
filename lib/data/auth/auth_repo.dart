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

  Future<void> logout() async => _dataSource.logout();



  Future<DataOrError<TyroUser>> loginWithGoogle() async {
    return _dataSource.loginWithGoogle();
  }

  Future<void> updateUserField({required String field, required String value}) async{
    return _dataSource.updateUserField(field: field, value: value);
  }
}
