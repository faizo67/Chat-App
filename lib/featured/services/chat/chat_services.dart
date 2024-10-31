import 'package:chat_app/featured/services/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // get instance of FireBase
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user Stream

  /*

  List<Map<String, dynamic>> = 

  [
  {
    "email": test@gmail.com,
    "password": 123456
  },
  {
    "email": hamza@gmail.com,
    "password": 123456
  },
  ]
  */
// get user Stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return firestore.collection("Users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          // go through each individual user
          final user = doc.data();

          // return user
          return user;
        }).toList();
      },
    );
  }

  // Get all User's Except Blocked Once and also currentOnce
  Stream<List<Map<String, dynamic>>> allUsersExceptBlockedStream() {
    final currentUser = _auth.currentUser;

    // Fetch Block User
    return firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection("BlockedUser")
        .snapshots()
        .asyncMap(
      (snapShot) async {
        // get block user ids
        final blockUserID = snapShot.docs.map((doc) => doc.id).toList();

        // get all User's
        final allUsers = await firestore.collection("Users").get();

        // return a Stream List
        return allUsers.docs
            .where(
              (doc) =>
                  doc.data()['email'] != currentUser.email &&
                  !blockUserID.contains(doc.id),
            )
            .map(
              (doc) => doc.data(),
            )
            .toList();
      },
    );
  }

  // send Message
  Future<void> sendMessage(String receiverID, String message) async {
    // get current user
    final String userID = _auth.currentUser!.uid;
    final String userEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create new message
    Message newMessage = Message(
        message: message,
        receiverID: receiverID,
        sendID: userID,
        senderEmail: userEmail,
        timestamp: timestamp);

    // construct chat room ID for the two user's (sorted to ensure Uniquness)
    List<String> ids = [userID, receiverID];
    ids.sort();
    String chatRoom = ids.join('_');

    // add new message to database
    await firestore
        .collection('Chat_room')
        .doc(chatRoom)
        .collection('message')
        .add(newMessage.toMap());
  }

  // get Message
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoom = ids.join('_');

    return firestore
        .collection('Chat_room')
        .doc(chatRoom)
        .collection('message')
        .orderBy('timestamp')
        .snapshots();
  }

  // Report User
  Future<void> reportUser(String userID, String messageId) async {
    final userValid = _auth.currentUser;

    final report = {
      // kn report kar raha hai
      'reportedBy': userValid!.uid,
      // kn sa message report kar raha hai
      'messageID': messageId,
      // kis ko report kar raha hai
      'messageOwnedID': userID,
      'timeStamp': FieldValue.serverTimestamp(),
    };
    await firestore.collection('Reporter').add(report);
  }

  // Blocking User
  Future<void> blockUser(String userID) async {
    final currentUser = _auth.currentUser;

    await firestore
        .collection("Users")
        .doc(currentUser!.uid)
        .collection('BlockedUser')
        .doc(userID)
        .set({'blockedAt': FieldValue.serverTimestamp()});
  }

  // UnBlocking User
  Future<void> unBlockUserID(String blockedUserID) async {
    final currentUSer = _auth.currentUser;

    await firestore
        .collection('Users')
        .doc(currentUSer!.uid)
        .collection('BlockedUser')
        .doc(blockedUserID)
        .delete();
  }

  // Get Blocked User Stream
  Stream<List<Map<String, dynamic>>> getBlockedUser(String userID) {
    return firestore
        .collection("Users")
        .doc(userID)
        .collection("BlockedUser")
        .snapshots()
        .asyncMap((snapshot) async {
      // get list of block user id's
      /*
          get the list like 
          [
          
          {'email': faiz@gmail.com, 'password': 1234},
          {'email': asad@gmail.com, 'password': 1234},
          {'email': Hamza@gmail.com, 'password': 1234},
        
          ]

          */
      final blockedUserIDs = snapshot.docs.map((doc) => doc.id).toList();

      // so that i get the one Map Value {'email': faiz@gmail.com, 'password': 1234}
      final userMapValue = await Future.wait(blockedUserIDs.map(
        (id) => firestore.collection('Users').doc(id).get(),
      ));

      // return a List
      return userMapValue
          .map(
              (singleDocValue) => singleDocValue.data() as Map<String, dynamic>)
          .toList();
    });
  }
}
