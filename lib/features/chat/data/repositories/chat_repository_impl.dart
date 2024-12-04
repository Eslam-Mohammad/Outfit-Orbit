import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';
import 'package:e_commerce_app/features/chat/domain/entities/chat_entity.dart';
import 'package:e_commerce_app/features/chat/domain/repositories/chat_repository.dart';

import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/exceptions.dart';
import '../data_sources/chat_remote_data_source.dart';

class ChatRepositoryImpl extends ChatRepository{

  final ChatRemoteDataSource chatRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatRepositoryImpl({required this.chatRemoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, Unit>> deleteChat(String userId)async {
    if(await networkInfo.isConnected!){
      try{
        await chatRemoteDataSource.deleteChat(userId);
        return  Future.value(const Right(unit));

      }
      on ServerException catch(e){
        return Future.value(Left(Failure(errMessage: e.errorModel.errorMessage)));
      }

    }
    else{
      return Future.value( Left( Failure(errMessage: "No Internet Connection")));

    }

  }

  @override
  Future<Either<Failure, Unit>> deleteMessage(MessageEntity message, String userId) async{
    if(await networkInfo.isConnected!){
      try{
        await chatRemoteDataSource.deleteMessage(message, userId);
        return  Future.value(const Right(unit));

      }
      on ServerException catch(e){
        return Future.value(Left(Failure(errMessage: e.errorModel.errorMessage)));
      }

    }
    else{
      return Future.value( Left( Failure(errMessage: "No Internet Connection")));

    }

  }

  @override
  Future<Either<Failure, Unit>> sendAdminMessage(MessageEntity message, String userId) async{

    if(await networkInfo.isConnected!){
      try{
        await chatRemoteDataSource.sendAdminMessage(message, userId);
        return  Future.value(const Right(unit));

      }
      on ServerException catch(e){
        return Future.value(Left(Failure(errMessage: e.errorModel.errorMessage)));
      }

    }
    else{
      return Future.value( Left( Failure(errMessage: "No Internet Connection")));

    }
  }

  @override
  Future<Either<Failure, Unit>> sendUserMessage(MessageEntity message) async{
    if(await networkInfo.isConnected!){
      try{
        await chatRemoteDataSource.sendUserMessage(message);
        return  Future.value(const Right(unit));

      }
      on ServerException catch(e){
        return Future.value(Left(Failure(errMessage: e.errorModel.errorMessage)));
      }

    }
    else{
      return Future.value( Left( Failure(errMessage: "No Internet Connection")));

    }

  }

}

