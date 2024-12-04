import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/chat/domain/entities/chat_entity.dart';

import '../../../../core/errors/failure.dart';

abstract class ChatRepository{
  Future<Either<Failure,Unit>> sendUserMessage(MessageEntity message);
  Future<Either<Failure,Unit>> sendAdminMessage(MessageEntity message , String userId);
  Future<Either<Failure,Unit>> deleteMessage(MessageEntity message, String userId);
  Future<Either<Failure,Unit>> deleteChat(String userId);



}