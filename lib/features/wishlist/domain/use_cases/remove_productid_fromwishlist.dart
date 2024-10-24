import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/wishlist_repository.dart';

class RemoveProductIdFromWishlist{

  final WishlistRepository repository;

  RemoveProductIdFromWishlist(this.repository);

  Future<Either<Failure,Unit>> call(int productId) async {
    return await repository.removeProductIdFromWishlist(productId);
  }
}