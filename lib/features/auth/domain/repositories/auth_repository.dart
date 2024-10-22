
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import '../../../../core/errors/failure.dart';



abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, AuthEntity>> signUpWithEmailAndPassword(
      {required String email, required String password, required String displayName});

  Future<Either<Failure, AuthEntity>> signInWithGoogle();

  Future <Either<Failure,Unit>> signOut();

  Future <Either<Failure,Unit>> resetPassword({required String email});

}

