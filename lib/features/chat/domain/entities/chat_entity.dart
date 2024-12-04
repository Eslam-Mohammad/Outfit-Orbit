class MessageEntity{
  final String content;
  final String time;
   bool isMe;
  final String type;

  MessageEntity({required  this.content,required  this.time,required  this.isMe,required  this.type});


}


class ChatEntity{
  final String uid;
  final String lastMessage;
  final String lastUpdated;
   List<MessageEntity>? messages;

  ChatEntity({required  this.uid,required  this.lastMessage,required  this.lastUpdated,  this.messages});


}