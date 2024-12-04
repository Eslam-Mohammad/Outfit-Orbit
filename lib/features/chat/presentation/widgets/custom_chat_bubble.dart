import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../core/services/service_locator_get_it.dart';
import '../../domain/entities/chat_entity.dart';
import '../manager/chat_cubit.dart';

class CustomChatBubble extends StatelessWidget {
  const CustomChatBubble({
    super.key,
    required this.message,
    required this.uid,
  });
 final String uid;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: InkWell(
        onLongPress: () {
          AwesomeDialog(
            dialogBackgroundColor: Color(0xff202c36),
              titleTextStyle: const TextStyle(color: Colors.white),
              context: context,
              dialogType: DialogType.noHeader,
              animType: AnimType.scale,
              title: 'Delete this Message',

              btnCancelOnPress: () {},
          btnOkOnPress: () {
                //delete message logic
            getIt<ChatCubit>().deleteMessageMethod(
              message: message,
              userId: uid,
            );

          },
          ).show();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: message.isMe ? Color(0xff084542) : Color(0xff202c36),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: message.isMe ? Radius.circular(15) : Radius.zero,
              bottomRight: message.isMe ? Radius.zero : Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: message.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                message.content,
                style: TextStyle(
                    color: message.isMe ? Colors.white : Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                '${DateTime.parse(message.time).hour > 12 ? DateTime.parse(message.time).hour - 12 : DateTime.parse(message.time).hour == 0 ? '12' : DateTime.parse(message.time).hour}:${DateTime.parse(message.time).minute > 9 ? DateTime.parse(message.time).minute : "0${DateTime.parse(message.time).minute}"} ${DateTime.parse(message.time).hour >= 12 ? 'PM' : 'AM'}',
                style: TextStyle(
                    color: message.isMe ? Colors.white70 : Colors.white70,
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
