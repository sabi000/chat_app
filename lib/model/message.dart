import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message(
    this.senderID,
    this.senderEmail,
    this.receiverID,
    this.message,
    this.timestamp,
  );

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderID,
      'senderEmail': senderEmail,
      'receiverId': receiverID,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
