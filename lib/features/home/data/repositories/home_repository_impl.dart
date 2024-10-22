import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/connection/network_info.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/features/home/data/data_sources/home_remote_datasource.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/domain/repositories/home_repository.dart';

import '../../../../core/errors/failure.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo netWorkInfo;

  HomeRepositoryImpl({required this.remoteDataSource,required this.netWorkInfo});

  @override
  Future<Either<Failure, List<BannerEntity>>> getBanners() async{
    if(await netWorkInfo.isConnected!)
      {
        try{
          final result=await remoteDataSource.getBanners();
          return Right(result);
        }on ServerException catch(e){

          return Left(Failure(errMessage: e.errorModel.errorMessage));
        }on RetryException catch(e){
          return Left(Failure(errMessage: e.errorMessage));
        }
      }
    else
      {
        return Left(Failure(errMessage: "No Internet Connection"));
      }
  }

  @override
  Future<Either<Failure,List<ProductEntity> >> getProducts() async{
    if(  await   netWorkInfo.isConnected!)
      {
        try{
          final result =await remoteDataSource.getProducts();
          return Right(result);
        }on ServerException catch(e){
          return Left(Failure(errMessage: e.errorModel.errorMessage));
        }on RetryException catch(e){
          return Left(Failure(errMessage: e.errorMessage));
        }
      }
    else
      {
        return Left(Failure(errMessage: "No Internet Connection"));
      }
  }


}