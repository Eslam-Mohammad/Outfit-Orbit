import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/error_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../auth/data/models/auth_model.dart';
import '../../domain/entities/chat_entity.dart';

class ChatRemoteDataSource{


  Future<String> getDocumentIdOfChat( String uid) async {
    try {
      QuerySnapshot query = await FirebaseFirestore.instance.collection("chats").where("userId", isEqualTo: uid).get();
      if (query.docs.isNotEmpty) {
        return query.docs.first.id;
      } else {
        DocumentReference docRef = await FirebaseFirestore.instance.collection("chats").add({
          "userId": uid,
          "lastMessage": "",
          "lastUpdate": DateTime.now()
        });
        await docRef.collection("messages").add({});
        return docRef.id;
      }
    } catch (e) {
      log("Error getting chat id: ${e.toString()}");
      throw ServerException(ErrorModel(errorMessage: "Error getting chat id or making new chat doc", status: 500));
    }
  }

  Future<Unit> sendUserMessage(MessageEntity message) async {
    try {
      var docId = await getDocumentIdOfChat(FirebaseAuth.instance.currentUser!.uid);
      await FirebaseFirestore.instance.collection("chats").doc(docId).update({
        "lastMessage":message.content,
        "lastUpdate":message.time
      });
      await FirebaseFirestore.instance.collection("chats").doc(docId).collection("messages").add({

        "content":message.content,
        "time":message.time,
        "isMe":true,
        "type":message.type

      });
      return unit;

    }
    catch (e) {
      throw ServerException(ErrorModel(errorMessage: "Error sending message from user",status: 500)   );

    }


  }

Future<Unit> deleteChat(String userId) async {
    try {
      var docId = await getDocumentIdOfChat(userId);
      await FirebaseFirestore.instance.collection("chats").doc(docId).delete();
      return unit;
    } catch (e) {
      throw ServerException(ErrorModel(errorMessage: "Error deleting chat",status: 500)   );
    }
  }

  Future<Unit> deleteMessage(MessageEntity message , String uid) async {
    try {
      var docId = await getDocumentIdOfChat(uid);
      await FirebaseFirestore.instance.collection("chats").doc(docId).collection("messages").where("content", isEqualTo: message.content).where("time",isEqualTo: message.time).get().then((value) {
       value.docs.first.reference.delete();
      });
      return unit;
    } catch (e) {
      throw ServerException(ErrorModel(errorMessage: "Error deleting message",status: 500)   );
    }
  }

  Future<Unit> sendAdminMessage(MessageEntity message, String userId) async {
    try {
      var docId = await getDocumentIdOfChat(userId);
      await FirebaseFirestore.instance.collection("chats").doc(docId).update({
        "lastMessage":message.content,
        "lastUpdate":message.time
      });
      await FirebaseFirestore.instance.collection("chats").doc(docId).collection("messages").add({

        "content":message.content,
        "time":message.time,
        "isMe":false,
        "type":message.type

      });
      return unit;

    }
    catch (e) {
      throw ServerException(ErrorModel(errorMessage: "Error sending message from admin",status: 500)   );

    }
  }

Future<AuthModel>bringCustomerInfo(String uid) {

    final query= FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: uid).get();
    return query.then((value) => AuthModel.fromJson(value.docs.first.data() as Map<String,dynamic>));

}





}