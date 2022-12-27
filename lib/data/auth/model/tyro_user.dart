import 'package:firebase_auth/firebase_auth.dart';

class TyroUser {
  final String id;
  final String? email;
  final String? name;
  final String? phone;
  final String? photoUrl;
  TyroUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.photoUrl,
  });

  factory TyroUser.fromMap(Map<String, dynamic> userMap) {
    return TyroUser(
      id: userMap['id'],
      email: userMap['email'],
      name: userMap['name'],
      phone: userMap['phone'],
      photoUrl: userMap['photoUrl'],
    );
  }

    factory TyroUser.fromFirebaseUser(User firebaseUser) {
    return TyroUser(
      id: firebaseUser.uid,
      email:firebaseUser.email,
      name: firebaseUser.displayName,
      phone: firebaseUser.phoneNumber,
      photoUrl: firebaseUser.photoURL,
    );
  }
}
