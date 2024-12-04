import 'dart:developer';

import 'package:e_commerce_app/features/chat/domain/use_cases/delete_chat.dart';
import 'package:e_commerce_app/features/chat/domain/use_cases/send_user_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_entity.dart';
import '../../domain/use_cases/delete_message.dart';
import '../../domain/use_cases/send_admin_message.dart';
import 'chat_state.dart';



class ChatCubit extends Cubit<ChatStates>{
  ChatCubit({
   required this.deleteChat,
    required this.deleteMessage,
    required this.sendUserMessage,
    required this.sendAdminMessage,
  }) : super(ChatInitialState());
  final DeleteChat deleteChat;
  final DeleteMessage deleteMessage;
  final SendUserMessage sendUserMessage;
  final SendAdminMessage sendAdminMessage;


  String? userIdAdminSentTo;


  void deleteChatMethod({required String userId}) async {
    emit(DeleteChatLoadingState());
    final result = await deleteChat(userId: userId);
    result.fold(
          (error) => emit(DeleteChatFailureState(error.errMessage)),
          (success) => emit(DeleteChatSuccessState()),
    );
  }

  void deleteMessageMethod({required MessageEntity message ,required String userId}) async {
    emit(DeleteMessageLoadingState());
    final result = await deleteMessage(message: message, userId: userId);
    result.fold(
          (error) => emit(DeleteMessageFailureState(error.errMessage)),
          (success) => emit(DeleteMessageSuccessState()),
    );
  }

  void sendUserMessageMethod({required MessageEntity message}) async {
    emit(SendMessageLoadingState());
    final result = await sendUserMessage(message);
    result.fold(
          (error) => emit(SendMessageFailureState(error.errMessage)),
          (success) => emit(SendMessageSuccessState()),
    );
  }

  void sendAdminMessageMethod({required MessageEntity message ,required String userId}) async {
    emit(SendAdminMessageLoadingState());
    final result = await sendAdminMessage(message: message, userId: userId);
    result.fold(
          (error) {
            log(error.errMessage);
            emit(SendAdminMessageFailureState(error.errMessage));
          },
          (success) => emit(SendAdminMessageSuccessState()),
    );
  }


}