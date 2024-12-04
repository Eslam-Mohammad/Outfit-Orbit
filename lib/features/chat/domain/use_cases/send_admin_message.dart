import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/features/chat/domain/entities/chat_entity.dart';

import '../../../../core/errors/failure.dart';
import '../repositories/chat_repository.dart';

class SendAdminMessage {
  final ChatRepository chatRepository;

  SendAdminMessage(this.chatRepository);

  Future<Either<Failure, Unit>> call(
      {required MessageEntity message,required String userId}) async {
    return await chatRepository.sendAdminMessage(message, userId);
  }
}