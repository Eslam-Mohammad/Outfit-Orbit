import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../data_sources/cart_local_datasource.dart';
import '../data_sources/cart_remote_datasource.dart';

class CartRepositoryImpl extends CartRepository{
  // take from wishlist repository impl class to auto complete with me here
 CartRemoteDataSource cartListRemoteDataSource;

 CartLocalDataSource  cartListLocalDataSource;
  NetworkInfo networkInfo;
  CartRepositoryImpl({
    required this.networkInfo,
    required this.cartListRemoteDataSource,
    required this.cartListLocalDataSource,
  });





  @override
  Future<Either<Failure, Unit>> addProductIdToCartList(int productId)async {
    if(await networkInfo.isConnected!){
      try {
        return Right(await cartListRemoteDataSource.addProductIdToCartList(productId));
    }on ServerException catch (e) {
    return Left(Failure(errMessage: e.errorModel.errorMessage));
    }
    }else{
    return Left(Failure(errMessage: 'No Internet Connection'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getCartList()async {
    if(await networkInfo.isConnected!){
      try {
        final cartList = await cartListRemoteDataSource.getCartList();
        cartListLocalDataSource.cacheCartList(cartList);
        return Right(cartList);
      }on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }else{
      try {
        final cartList = await cartListLocalDataSource.getCachedCartList();
        return Right(cartList);
      } catch (e) {
        return Left(Failure(errMessage: 'No Internet Connection and no cache data'));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> removeProductIdFromCartList(int productId) async {
    if(await networkInfo.isConnected!){
      try {
        return Right(await cartListRemoteDataSource.removeProductIdFromCartList(productId));
      }on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }else{
      return Left(Failure(errMessage: 'No Internet Connection'));
    }


  }


}