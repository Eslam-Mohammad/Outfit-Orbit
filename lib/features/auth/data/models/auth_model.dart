

import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';


class AuthModel extends AuthEntity {
  AuthModel({
    required super.id,
    required super.email,
    required super.displayName,
    super.imageUrl,
    super.phoneNumber,
  });




  factory AuthModel.fromFirebaseUser(firebaseUser) {
    return AuthModel(
      id: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,

      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json['id'],
      email: json['email'],
      displayName: json['displayName'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }
}
