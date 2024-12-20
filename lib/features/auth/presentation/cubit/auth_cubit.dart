
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/get_admin_status.dart';
import 'package:e_commerce_app/features/cart/presentation/manager/cart_cubit.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/services/service_locator_get_it.dart';
import '../../data/models/auth_model.dart';
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
  final GetAdminStatus getAdminStatus;



  AuthCubit(
      {

      required this.signInWithGoogle,
      required this.signInWithEmailAndPassword,
      required this.signOut,
      required this.resetPassword,
      required this.signUpWithEmailAndPassword,
      required this.getAdminStatus,
      }) : super(AuthInitial()){

    theUserInformation= AuthModel.fromFirebaseUser(FirebaseAuth.instance.currentUser);
     getDocumentId();
  }

Future<void>getDocumentId ()async{
  theUserInformation!.documentId=await AuthRemoteDataSource().bringUserDocumentId();
}

  bool? isAgreed ;
  void agreeToTerms(bool value) {
    isAgreed = value;
    emit(CheckAuth());
  }
  bool? isAdmin;

  Future<void> checkAdminStatus() async {
    final result = await getAdminStatus();
    result.fold(
          (failure) => emit(GetAdminStatusFailure(message: failure.errMessage)),
          (status) {
            isAdmin = status;
            emit(GetAdminStatusSuccess());
          },
    );
  }



  AuthEntity? theUserInformation;



  Future<void> signInWithEmail (String email, String password) async {
    emit(SignInLoading());
    final result = await signInWithEmailAndPassword(email, password);
    result.fold(
          (failure) => emit(SignInFailure(message: failure.errMessage)),
          (authEntity)  {
            theUserInformation = authEntity;
            log("*****************${theUserInformation?.documentId??"no document id found"}");
            emit(SignInSuccess(authEntity: authEntity));
            getIt<CartCubit>().getCart();
            getIt<WishlistCubit>().getWishlist();
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
              "uid":authEntity.uid,
              "imageUrl":authEntity.imageUrl,
              "phoneNumber":authEntity.phoneNumber,
            });
            theUserInformation = authEntity;
            emit(GoogleSuccess(authEntity: authEntity));
            getIt<CartCubit>().getCart();
            getIt<WishlistCubit>().getWishlist();
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
  QuerySnapshot querySnapshot = await users.where('uid', isEqualTo: userInfo['uid']).get();

  if (querySnapshot.docs.isEmpty) {
    await users.add(userInfo);

  }
}



}
