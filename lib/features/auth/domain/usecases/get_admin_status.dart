import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/auth_repository.dart';

class GetAdminStatus{
  final AuthRepository repository;

  GetAdminStatus(this.repository);

  Future<Either<Failure,bool>> call() async {
    return await repository.getAdminStatus();
  }
}