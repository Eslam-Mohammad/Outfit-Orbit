import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/connection/network_info.dart';
import 'package:e_commerce_app/core/errors/exceptions.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:e_commerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:e_commerce_app/features/auth/domain/entities/auth_entitiy.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, AuthEntity>> signInWithEmailAndPassword({required String email, required String password}) async{
   if(await networkInfo.isConnected!){
     try{
       var user = await remoteDataSource.signInWithEmailAndPassword(email: email, password: password);
       user.documentId= await remoteDataSource.bringUserDocumentId();
       localDataSource.cacheAuth(user);
       return Right(user);
     }on ServerException catch (e)
     {
       return Left(Failure(errMessage: e.errorModel.errorMessage));
     }
   }else{

     try{
        final user = await localDataSource.getLastCachedAuth();
        return Right(user);
     }
      on CacheException catch (e){
        return Left(Failure(errMessage: e.errorMessage));
      }
   }



  }

  @override
  Future<Either<Failure, AuthEntity>> signInWithGoogle() async{
    if(await networkInfo.isConnected!){
      try{
        print("*********************************************trying repositoryimpl method in sign in with google");
        final user = await remoteDataSource.signInWithGoogle();
        print("****************didnot go to cache");
        localDataSource.cacheAuth(user);
        return Right(user);
      }on ServerException catch (e)
      {
        print("*********************************************exception in sign in with google in repositoryimpl${e.errorModel.errorMessage}");
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }else{

      try{
        final user = await localDataSource.getLastCachedAuth();
        return Right(user);
      }
      on CacheException catch (e){
        return Left(Failure(errMessage: e.errorMessage));
      }
    }

  }

  @override
  Future<Either<Failure, AuthEntity>> signUpWithEmailAndPassword({required String email, required String password,required String displayName}) async{
   if(await networkInfo.isConnected!) {
     try {
       print("*********************************************trying repositoryimpl method in sign up with email");
       final user =await remoteDataSource.signUpWithEmailAndPassword(
           email: email, password: password, displayName: displayName);
       localDataSource.cacheAuth(user);
       return Right(user);
     } on ServerException catch (e) {
       print("*********************************************exception in sign up with email in repositoryimpl");
       print("*********************************************trying ${e.errorModel.errorMessage} ");
       return Left(Failure(errMessage: e.errorModel.errorMessage));
     }
   }
     else{
       try{
          final user = await localDataSource.getLastCachedAuth();
          return Right(user);
       }on CacheException catch (e){
         return Left(Failure(errMessage: e.errorMessage));
       }

   }
   }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected!) {
      try {
        await remoteDataSource.signOut();
        localDataSource.clearCache();
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }
    else{
      return Left(Failure(errMessage: "No Internet Connection"));
    }


  }

  @override
  Future<Either<Failure, Unit>> resetPassword({required String email})async {
    if(await networkInfo.isConnected!) {
      try {
        remoteDataSource.resetPassword(email: email);
        return const Right(unit);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    }else{
      return Left(Failure(errMessage: "No Internet Connection"));
    }



  }





  }




