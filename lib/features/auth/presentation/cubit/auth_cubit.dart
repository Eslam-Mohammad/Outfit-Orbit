
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool? isAgreed = false;
  void agreeToTerms(bool value) {
    isAgreed = value;
    emit(CheckAuth());
  }


  void verifyEmail() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }









  void resetPassword(String email) async{
    emit(ResetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ResetPasswordFailed(message: 'No user found for that email.'));

      }
      else{
        emit(ResetPasswordFailed(message: e.toString()));
      }
    } catch (e) {
      emit(ResetPasswordFailed(message: e.toString()));

    }

  }


void addUserInfo(Map<String,dynamic>userInfo) async{
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users.add(userInfo)
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));

}




}
