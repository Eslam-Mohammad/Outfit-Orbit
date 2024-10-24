import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/cart_repository.dart';

class RemoveProductIdFromCartList {
  final CartRepository cartRepository;

  RemoveProductIdFromCartList(this.cartRepository);

  Future<Either<Failure,Unit>> call(int productId) async {
    return cartRepository.removeProductIdFromCartList(productId);
  }
}