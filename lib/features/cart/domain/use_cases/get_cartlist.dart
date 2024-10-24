import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../repositories/cart_repository.dart';

class GetCartList {
  final CartRepository repository;

  GetCartList(this.repository);

  Future<Either<Failure,List<ProductEntity>>> call() async {
    return await repository.getCartList();
  }
}