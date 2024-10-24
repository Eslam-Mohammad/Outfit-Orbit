import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

abstract class CartRepository {
  Future<Either<Failure,Unit>> addProductIdToCartList(int productId);
  Future<Either<Failure,Unit>> removeProductIdFromCartList(int productId);
  Future<Either<Failure,List<ProductEntity>>> getCartList();
}