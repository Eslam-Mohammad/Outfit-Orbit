import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_entity.dart';
import '../repositories/chat_repository.dart';

class DeleteMessage{
  final ChatRepository repository;

  DeleteMessage(this.repository);

  Future<Either<Failure, Unit>> call({required MessageEntity message,required String userId}) async {
    return repository.deleteMessage(message, userId);
  }
}