import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';
import '../../data/data_sources/chat_remote_data_source.dart';
import '../../data/models/chat_model.dart';




class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  final Stream<QuerySnapshot> chatStream = FirebaseFirestore.instance.collection("chats").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff202c36),
        title: const Text("Admin Chat",
          style: TextStyle(color: Colors.grey),
        ),

      ),
      body: Container(
        color: const Color(0xff111d26),
        child: StreamBuilder<QuerySnapshot>(
          stream:chatStream,
          builder: (context,snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            List<ChatModel> chats = snapshot.data!.docs.map((e) =>
                ChatModel.fromJson(e.data() as Map<String, dynamic>)).toList();
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Color(0xff1e2a33),
              ),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: ChatRemoteDataSource().bringCustomerInfo(
                      chats[index].uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading data'));
                    }
                    final customerInfo = snapshot.data;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(customerInfo?.displayName?[0] ?? "N"),
                      ),
                      title: Text(customerInfo?.displayName ?? "no name" ,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(chats[index].lastMessage,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        '${DateTime.parse(chats[index].lastUpdated).hour > 12 ? DateTime.parse(chats[index].lastUpdated).hour - 12 : DateTime.parse(chats[index].lastUpdated).hour ==0? '12':DateTime.parse(chats[index].lastUpdated).hour }:${DateTime.parse(chats[index].lastUpdated).minute > 9?DateTime.parse(chats[index].lastUpdated).minute: "0${DateTime.parse(chats[index].lastUpdated).minute}" } ${DateTime.parse(chats[index].lastUpdated).hour >= 12 ? 'PM' : 'AM'}',
                        style: const TextStyle(color: Color(0xff02b09c)),
                      ),
                      onTap: () async {
                        Stream<QuerySnapshot> messagesStream = FirebaseFirestore
                            .instance
                            .collection('chats')
                            .doc(
                            await ChatRemoteDataSource().getDocumentIdOfChat(
                                chats[index].uid))
                            .collection("messages")
                            .orderBy("time", descending: true)
                            .snapshots();
                        GoRouter.of(context).push(chatPath, extra: {
                          'messagesStream': messagesStream,
                          'userIdToChatWith': chats[index].uid,
                        });
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );


  }
}



String removeAfter16Chars(String input) {
  if (input.length > 16) {
    return input.substring(0, 16);
  }
  return input; // Return the original string if it is 16 characters or less
}