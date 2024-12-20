

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/error_model.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthRemoteDataSource {

  AuthRemoteDataSource();

  Future<bool> getAdminStatus()async{
    try{
      QuerySnapshot query =await FirebaseFirestore.instance.collection('admins').where('admin', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      if(query.docs.isNotEmpty){
        return Future.value(true);
      }else{
        return Future.value(false);
      }
    }catch(e){
      throw ServerException( ErrorModel(status:0 ,errorMessage: "Server Error"));
    }

  }

  Future<String> bringUserDocumentId()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Get the document ID
      return querySnapshot.docs.first.id;
    }

    return "";

  }

   Future<AuthModel> signInWithEmailAndPassword  ({required String email, required String password}) async{
    try {

       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );


      return AuthModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {

       throw ServerException( ErrorModel(status:0 ,errorMessage: 'No user found for that email.'));

      }
      else if (e.code == 'wrong-password')
      {

        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Wrong Password'));

      }
      else{

        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Try Again Later'));
      }
    } catch (e) {

      throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

    }



  }



  Future<AuthModel> signUpWithEmailAndPassword  ({required String email, required String password,required String displayName}) async{
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: displayName);
      await userCredential.user!.reload();
      await userCredential.user!.sendEmailVerification();
      return AuthModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'No user found for that email.'));

      }
      else if (e.code == 'wrong-password')
      {
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Wrong Password'));

      } else if (e.code == 'email-already-in-use')
      {
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'email already in use'));

      }
      else{
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Try Again Later'));
      }
    } catch (e) {
      throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

    }



  }

  Future <AuthModel> signInWithGoogle()async{

     try{


         // Trigger the authentication flow
         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          if(googleUser==null){

            throw ServerException(ErrorModel(status: 0, errorMessage: 'Google sign-in aborted.'));
          }


         // Obtain the auth details from the request
         final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

         // Create a new credential
         final credential = GoogleAuthProvider.credential(
           accessToken: googleAuth?.accessToken,
           idToken: googleAuth?.idToken,
         );

         // Once signed in, return the UserCredential
          final userCredential=await FirebaseAuth.instance.signInWithCredential(credential);


         return AuthModel.fromFirebaseUser(userCredential.user!);

     }on PlatformException catch (e) {

       throw ServerException(ErrorModel(status: 0, errorMessage: 'Platform error: ${e.message}'));
     } catch(e){

       throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

     }

   }

  Future<Unit> signOut() async {

     try {
       await FirebaseAuth.instance.signOut();
       final googleSignIn = GoogleSignIn();
       if (await googleSignIn.isSignedIn()) {

         await googleSignIn.disconnect();
         await googleSignIn.signOut();
       }

        return Future.value(unit);

     }catch(e){

       throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

     }
   }

   Future <Unit> resetPassword({required String email}) async{
     try {
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
       return Future.value(unit);
     }catch(e){
       throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));
     }
   }





}
