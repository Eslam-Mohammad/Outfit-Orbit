import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/errors/failure.dart';

import '../repositories/chat_repository.dart';

class DeleteChat{
  final ChatRepository chatRepository;

  DeleteChat(this.chatRepository);

  Future<Either<Failure,Unit >> call({required String userId}) async {
    return await chatRepository.deleteChat(userId);
  }
}