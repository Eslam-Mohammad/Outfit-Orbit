

import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';


class AuthModel extends AuthEntity {
  AuthModel({
    required super.uid,
    required super.email,
    super.documentId,
    super.displayName,
    super.imageUrl,
    super.phoneNumber,
    super.address,
    super.paymentMethods,
    super.orderHistory,
  });




  factory AuthModel.fromFirebaseUser(firebaseUser) {
    return AuthModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email,
      displayName: firebaseUser.displayName,


      phoneNumber: firebaseUser.phoneNumber,
    );
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      uid: json['uid'],
      email: json['email'],
      documentId: json['documentId'],
      displayName: json['displayName'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      paymentMethods: json['paymentMethods'],
      orderHistory: json['orderHistory'],
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'documentId': documentId,
      'displayName': displayName,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'address': address,
      'paymentMethods': paymentMethods,
      'orderHistory': orderHistory,
    };
  }
}
