
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';

class SignUpWithEmailAndPassword {
  final AuthRepository repository;

  SignUpWithEmailAndPassword(this.repository);

  Future<Either<Failure, AuthEntity>> call(String email ,String password) async {
    return await repository.signUpWithEmailAndPassword(email:email, password:password);
  }
}