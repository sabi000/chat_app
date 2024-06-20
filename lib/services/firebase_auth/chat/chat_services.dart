import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SEND MESSAGE
  Future<void> sendMessage(String receiverID, String message) async {
    //get the sender info
    final String senderID = _firebaseAuth.currentUser!.uid;
    final String senderEmail = _firebaseAuth.currentUser!.email.toString();
    //get the current timestamp
    final Timestamp timestamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
      senderID,
      senderEmail,
      receiverID,
      message,
      timestamp,
    );

    //create a chat room id for the current sender and receiver
    List<String> ids = [senderID, receiverID];
    ids.sort(); //ensure that the chat room id is same for a pair
    String chatRoomID = ids.join("_");

    //add the message to the database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //RECEIVE MESSAGES
  Stream<QuerySnapshot> receiveMessage(String userID, String otherUserID) {
    //construct the chat room ID
    List<String> ids = [userID, otherUserID];
    ids.sort(); //ensure that the chat room id is same for a pair
    String chatRoomID = ids.join("_");

    //return the snapshots
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
