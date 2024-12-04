

import '../../domain/entities/chat_entity.dart';

class MessageModel extends MessageEntity{
  MessageModel({
    required  super.content,
    required  super.time,
    required  super.isMe,
    required  super.type,
  }) ;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      content: json['content'],
      time: json['time'],
      isMe: json['isMe'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'time': time,
      'isMe': isMe,
      'type': type,
    };
  }
}


class ChatModel extends ChatEntity{

  ChatModel({
    required  super.uid,
    required  super.lastMessage,
    required  super.lastUpdated,
      super.messages,
  }) ;

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      uid: json['userId'],
      lastMessage: json['lastMessage'],
      lastUpdated: json['lastUpdate'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': uid,
      'lastMessage': lastMessage,
      'lastUpdated': lastUpdated,

      };

    }
  }




