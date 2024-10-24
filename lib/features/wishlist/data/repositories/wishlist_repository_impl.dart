import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';

import 'package:e_commerce_app/core/errors/failure.dart';

import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/wishlist/data/data_sources/wishlist_local_datasource.dart';
import 'package:e_commerce_app/features/wishlist/data/data_sources/wishlist_remote_datasource.dart';

import '../../../../core/connection/network_info.dart';
import '../../domain/repositories/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  WishlistRemoteDataSource wishlistRemoteDataSource;
  WishlistLocalDataSource wishlistLocalDataSource;
  NetworkInfo networkInfo;
  WishlistRepositoryImpl({
    required this.networkInfo,
    required this.wishlistRemoteDataSource,
    required this.wishlistLocalDataSource,
  });

  @override
  Future<Either<Failure, Unit>> addProductIdToWishlist(int productId) async{
   if(await networkInfo.isConnected!){
      try {
        return Right(await wishlistRemoteDataSource.addProductIdToWishlist(productId));
      }on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
   }else{
     return Left(Failure(errMessage: 'No Internet Connection'));
   }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getWishlist()async {
    if(await networkInfo.isConnected!){
      try {
        final wishlist = await wishlistRemoteDataSource.getWishlist();
        wishlistLocalDataSource.CacheWishlist(wishlist);
        return Right(wishlist);
      }on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }else{
      try {
        final wishlist = await wishlistLocalDataSource.getWishlist();
        return Right(wishlist);
      } catch (e) {
        return Left(Failure(errMessage: 'No Internet Connection and no cache data'));
      }
    }

  }

  @override
  Future<Either<Failure, Unit>> removeProductIdFromWishlist(int productId)async {
    if(await networkInfo.isConnected!){
      try {
        return Right(await wishlistRemoteDataSource.removeProductIdFromWishlist(productId));
    }on ServerException catch (e) {
    return Left(Failure(errMessage: e.errorModel.errorMessage));
    }
    }else{
    return Left(Failure(errMessage: 'No Internet Connection'));
    }


  }



}