

import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';


class AuthModel extends AuthEntity {
  AuthModel({
    required super.id,
    required super.email,
    required super.displayName,
    super.photoUrl,
    super.phoneNumber,
  });




  factory AuthModel.fromFirebaseUser(firebaseUser) {
    return AuthModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,
      photoUrl: firebaseUser.photoURL,
      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      photoUrl: json['photoUrl'],
      phoneNumber: json['phoneNumber'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
    };
  }
}
