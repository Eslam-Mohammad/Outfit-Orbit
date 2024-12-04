class ChatStates {}
class ChatFailure extends ChatStates{
  final String errMessage;
  ChatFailure(this.errMessage);
}
class ChatInitialState extends ChatStates {}
class SendMessageSuccessState extends ChatStates {}
class SendMessageFailureState extends ChatFailure {

  SendMessageFailureState(super.error);
}
class SendMessageLoadingState extends ChatStates {}


class DeleteMessageSuccessState extends ChatStates {}
class DeleteMessageFailureState extends ChatFailure {

  DeleteMessageFailureState(super.error);
}
class DeleteMessageLoadingState extends ChatStates {}

class DeleteChatSuccessState extends ChatStates {}
class DeleteChatFailureState extends ChatFailure {

  DeleteChatFailureState(super.error);
}
class DeleteChatLoadingState extends ChatStates {}

class SendAdminMessageSuccessState extends ChatStates {}
class SendAdminMessageFailureState extends ChatFailure {

  SendAdminMessageFailureState(super.error);
}
class SendAdminMessageLoadingState extends ChatStates {}