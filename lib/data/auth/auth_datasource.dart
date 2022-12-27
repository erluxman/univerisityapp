import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:university_app/data/auth/model/tyro_user.dart';

import '../../utils/data/data_or_error.dart';

const baseUrl = "http://localhost:8080/api/v1";

class AuthDataSource {
  AuthDataSource();

  Future<DataOrError<TyroUser>> getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return DataOrError(
        error: ServerError.fromJson(
          {"message": "User not logged in"},
        ),
      );
    } else {
      return DataOrError(data: TyroUser.fromFirebaseUser(currentUser));
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<DataOrError<TyroUser>> loginWithEmailPassword(
      String email, String password) async {
    return DataOrError(error: ServerError.fromJson({}));
  }

  Future<Map<String, String>?> updateTokenFromEmailPassword(
      {required String email, required String password}) async {}

  Future<bool> submitPhoneForVerification(String phoneNumber) async {
    await Future.delayed(const Duration(seconds: 2));
    return Random().nextBool();
  }

  Future<bool> verifyCode(String phoneNumber, String verificationCode) async {
    await Future.delayed(const Duration(seconds: 2));
    if (verificationCode == '1234') {
      return true;
    } else if (verificationCode == '0000') {
      throw Exception('Code expired');
    } else {
      throw Exception('Invalid Code');
    }
  }

  Future<DataOrError<TyroUser>> loginWithGoogle() async {
    //  write code to login with google in firebase
    final FirebaseAuth auth = FirebaseAuth.instance;
    final AuthCredential credential = await _getGoogleCredential();
    final userCredential = await auth.signInWithCredential(credential);

    final user = userCredential.user;
    if (user == null) {
      return DataOrError(
          error: ServerError.fromJson(
        {"error": "No user found"},
      ));
    }

    return DataOrError<TyroUser>(
      data: TyroUser.fromFirebaseUser(user),
    );
  }

  Future<AuthCredential> _getGoogleCredential() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    return GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
  }
}
