import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/cart_repository.dart';

class AddProductIdToCartList {
  final CartRepository _cartRepository;

  AddProductIdToCartList(this._cartRepository);

  Future<Either<Failure,Unit>> call(int productId) async {
    return _cartRepository.addProductIdToCartList(productId);
  }
}