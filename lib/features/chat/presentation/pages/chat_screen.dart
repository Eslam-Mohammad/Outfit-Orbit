import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_commerce_app/features/chat/presentation/manager/chat_state.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/services/service_locator_get_it.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../data/models/chat_model.dart';


import '../../domain/entities/chat_entity.dart';

import '../widgets/custom_chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key, required this.messagesStream, this.userIdToChatWith = '' });

  final Stream<QuerySnapshot<Object?>> messagesStream;
  final String userIdToChatWith;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff202c36),
        title: const Text("Customer Service Chat",
          style: TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xff111d26),
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.messagesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            List<MessageEntity> messages = snapshot.data!.docs
                .map((e) =>
                MessageModel.fromJson(e.data() as Map<String, dynamic>))
                .toList();

            if(getIt<AuthCubit>().isAdmin!){
              messages.forEach((element){
                element.isMe = !element.isMe;
              });
            }

            return BlocListener<ChatCubit, ChatStates>(
              listener: (context, state) {
                if (state is ChatFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {

                        return CustomChatBubble(message: messages[index]);
                      },
                    ),
                  ),
                  const Divider(height: 1),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 5.0),
                    color: AppColors.fontPrimaryColor,
                    child: Row(
                      children: [
                        IconButton(

                          icon: const Icon(
                            Icons.camera_alt, color: Colors.grey,),
                          onPressed: () {
                            // logic to pic or take photo here
                          },
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: "Type a message",
                              hintStyle: const TextStyle(color: Color(0xffa7b2b8)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xff2a373d),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color(0xff084542),
                          ),
                          onPressed: () {
                            if (_messageController.text.isEmpty) {
                              return;
                            }

                            // logic to send message
                            if (getIt<AuthCubit>().isAdmin == true) {
                              getIt<ChatCubit>().sendAdminMessageMethod(
                                  message: MessageEntity(
                                      content: _messageController.text,
                                      time: DateTime.now().toString(),
                                      isMe: false,
                                      type: "text"
                                  ),
                                  userId: widget.userIdToChatWith
                              );
                            } else {
                              getIt<ChatCubit>().sendUserMessageMethod(
                                  message: MessageEntity(
                                      content: _messageController.text,
                                      time: DateTime.now().toString(),
                                      isMe: true,
                                      type: "text"
                                  )
                              );
                            }
                            _scrollController.animateTo(
                              0.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );

                            _messageController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
