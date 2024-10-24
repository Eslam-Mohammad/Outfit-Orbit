import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

abstract class WishlistRepository {
  Future<Either<Failure,Unit>> addProductIdToWishlist(int productId);
  Future<Either<Failure,Unit>> removeProductIdFromWishlist(int productId);
  Future<Either<Failure,List<ProductEntity>>> getWishlist();
}