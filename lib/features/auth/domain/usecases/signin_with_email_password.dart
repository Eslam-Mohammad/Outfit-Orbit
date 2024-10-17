

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithEmailAndPassword {
  final AuthRepository repository;

  SignInWithEmailAndPassword(this.repository);

  Future<Either<Failure, AuthEntity>> call(String email, String password) async {
    return await repository.signInWithEmailAndPassword(email:email, password:password);
  }
}