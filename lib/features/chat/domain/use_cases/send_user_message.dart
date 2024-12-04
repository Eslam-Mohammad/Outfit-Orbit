 import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/chat/domain/entities/chat_entity.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/chat_repository.dart';

class SendUserMessage {
  final ChatRepository repository;

  SendUserMessage(this.repository);

  Future<Either<Failure, Unit>> call(MessageEntity message) async {
    return repository.sendUserMessage(message);
  }
}