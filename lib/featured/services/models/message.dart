import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sendID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.receiverID,
      required this.sendID,
      required this.senderEmail,
      required this.timestamp});

  // convert to Map

  Map<String, dynamic> toMap() {
    return {
      'sendId': sendID,
      'sendEmail': receiverID,
      'receiverID': receiverID,
      'message': message,
      'timestamp': timestamp
    };
  }
}
