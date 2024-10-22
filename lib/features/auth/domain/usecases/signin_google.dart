

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';

import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle({required this.repository});

  Future<Either<Failure, AuthEntity>> call() async {

    return await repository.signInWithGoogle();
  }




}