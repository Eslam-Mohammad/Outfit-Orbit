

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/error_model.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthRemoteDataSource {

  AuthRemoteDataSource();

   Future<AuthModel> signInWithEmailAndPassword  ({required String email, required String password}) async{
    try {
      print("*********************************************trying remote method in sign in with email");
       await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("*********************************The current user before model in in sign in************${FirebaseAuth.instance.currentUser!}");
      return AuthModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("*********************************************${e.code}");
       throw ServerException( ErrorModel(status:0 ,errorMessage: 'No user found for that email.'));

      }
      else if (e.code == 'wrong-password')
      {
        print("*********************************************${e.code}");
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Wrong Password'));

      }
      else{
        print("*********************************************${e.toString()}");
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Try Again Later'));
      }
    } catch (e) {
      print("*********************************************${e.toString()}");
      throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

    }



  }



  Future<AuthModel> signUpWithEmailAndPassword  ({required String email, required String password,required String displayName}) async{
    try {
      print("*********************************************trying remote method in sign up up with email");
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.updateProfile(displayName: displayName);
      await userCredential.user!.reload();
      await userCredential.user!.sendEmailVerification();
      print("*********************************************${userCredential.user!.email}");
      print("*********************************************${userCredential.user!.displayName}");
      print("*********************************************${userCredential.user!.uid}");
      print("*********************************************${userCredential.user!}");
      print("*********************************************${FirebaseAuth.instance.currentUser!}");
      print("*********************************************before we convert to model in");
      return AuthModel.fromFirebaseUser(FirebaseAuth.instance.currentUser!);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("*********************************************${e.code}");
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'No user found for that email.'));

      }
      else if (e.code == 'wrong-password')
      {
        print("*********************************************${e.code}");
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Wrong Password'));

      }
      else{
        print("*********************************************problem happen in converting in remotedata");
        print("*********************************************${e.toString()}");
        throw ServerException( ErrorModel(status:0 ,errorMessage: 'Try Again Later'));
      }
    } catch (e) {
      print("*********************************************${e.toString()}");
      throw ServerException( ErrorModel(status:0 ,errorMessage: e.toString()));

    }



  }

  Future <AuthModel> signInWithGoogle()async{

     try{
          print("*********************************************trying remote method in sign in with google");

         // Trigger the authentication flow
         final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
         print("*********************************************${googleUser}");
         print("*********************************************After first line");
          if(googleUser==null){
            print("*********************************************dialog shown ? and user null");
            throw ServerException(ErrorModel(status: 0, errorMessage: 'Google sign-in aborted.'));
          }

          print("****************If google user was not null*****************************${googleUser.email}");
         // Obtain the auth details from the request
         final GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

         // Create a new credential
         final credential = GoogleAuthProvider.credential(
           accessToken: googleAuth?.accessToken,
           idToken: googleAuth?.idToken,
         );
          print("******************************** Credential made *************${credential.idToken}");
         // Once signed in, return the UserCredential
          final userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
          print("******************************** User made *************${userCredential.user!.email}");
         print("******************************** User made *************${userCredential.user!}");
         print("******************************** User made *************${FirebaseAuth.instance.currentUser!}");

         return AuthModel.fromFirebaseUser(userCredential.user!);

     }on PlatformException catch (e) {
       print("*********************************************PlatformException: ${e.message}");
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