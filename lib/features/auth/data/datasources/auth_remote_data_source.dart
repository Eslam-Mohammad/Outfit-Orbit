

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/error_model.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthRemoteDataSource {

  AuthRemoteDataSource();

   Future<AuthModel> signInWithEmailAndPassword  ({required String email, required String password}) async{
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthModel.fromFirebaseUser(userCredential.user!);

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



  Future<AuthModel> signUpWithEmailAndPassword  ({required String email, required String password}) async{
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
      return AuthModel.fromFirebaseUser(userCredential.user!);

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

     }catch(e){

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
