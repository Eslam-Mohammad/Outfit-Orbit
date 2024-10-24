import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/wishlist_repository.dart';

class AddProductIdToWishlist{


  final WishlistRepository repository;

  AddProductIdToWishlist(this.repository);

  Future<Either<Failure,Unit>> call(int productId) async {
    return await repository.addProductIdToWishlist(productId);
  }
}