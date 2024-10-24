
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/signin_google.dart';
import '../../domain/usecases/signin_with_email_password.dart';
import '../../domain/usecases/signout.dart';

import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/signup_email_password.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInWithGoogle signInWithGoogle;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final SignOut signOut;
  final ResetPassword resetPassword;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;



  AuthCubit(
      {
      required this.signInWithGoogle,
      required this.signInWithEmailAndPassword,
      required this.signOut,
      required this.resetPassword,
      required this.signUpWithEmailAndPassword}) : super(AuthInitial());



  bool? isAgreed ;
  void agreeToTerms(bool value) {
    isAgreed = value;
    emit(CheckAuth());
  }

  AuthEntity? theUserInformation;



  Future<void> signInWithEmail (String email, String password) async {
    emit(SignInLoading());
    final result = await signInWithEmailAndPassword(email, password);
    result.fold(
          (failure) => emit(SignInFailure(message: failure.errMessage)),
          (authEntity)  {
            theUserInformation = authEntity;
            emit(SignInSuccess(authEntity: authEntity));
          },
    );
  }

  Future<void> signWithGoogle() async {
    emit(GoogleLoading());
    final result = await signInWithGoogle();

    result.fold(
          (failure) => emit(GoogleFailure(message: failure.errMessage)),
          (authEntity) {
            addUserInfo({
              "email":authEntity.email,
              "displayName":authEntity.displayName,
              "uid":authEntity.id,
              "photoURL":authEntity.photoUrl,
              "phoneNumber":authEntity.phoneNumber,
            });
            theUserInformation = authEntity;
            emit(GoogleSuccess(authEntity: authEntity));
          },
    );
  }

  Future<void> signUpWithEmail(String email, String password,String displayName) async {
    emit(SignUpLoading());
    final result = await signUpWithEmailAndPassword(email, password,displayName);

    result.fold(
          (failure) => emit(SignUpFailure(message: failure.errMessage)),
          (authEntity){

        theUserInformation = authEntity;
        emit(SignUpSuccess(authEntity: authEntity));
      },
    );
  }


  Future<void> signOutUser() async {
    emit(SignedOutLoading());
    final result = await signOut();
    result.fold(
          (failure) => emit(SignedOutFailure(message: failure.errMessage)),
          (_) => emit(SignedOutSuccess()),
    );
  }


  Future<void> resetUserPassword(String email) async {
    emit(ResetPasswordLoading());
    final result = await resetPassword(email: email);
    result.fold(
          (failure) => emit(ResetPasswordFailure(message: failure.errMessage)),
          (_) => emit(ResetPasswordSuccess()),
    );
  }












Future<void> addUserInfo(Map<String, dynamic> userInfo) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  QuerySnapshot querySnapshot = await users.where('email', isEqualTo: userInfo['email']).get();

  if (querySnapshot.docs.isEmpty) {
    await users.add(userInfo)
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  } else {
    print("User already exists");
  }
}



}
