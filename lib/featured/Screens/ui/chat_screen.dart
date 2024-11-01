import 'dart:developer';
import 'dart:io';
import 'package:chat_app/core/utils/constants/Size.dart';
import 'package:chat_app/featured/Screens/widget/customWidget/chat_Bubble_item.dart';
import 'package:chat_app/featured/auth/service/auth_service.dart';
import 'package:chat_app/featured/auth/widget/my_textField.dart';
import 'package:chat_app/featured/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  final String receiverName;
  final String receiverID;
  ChatScreen({super.key, required this.receiverName, required this.receiverID});

  // text Controller
  final TextEditingController messageController = TextEditingController();

  // chat and Auth Service
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // send Message
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(receiverID, messageController.text, null);
      messageController.clear();
    }
  }

  // send Image
  void sendImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _chatServices.sendMessage(receiverID, null, imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Display Messages
          Expanded(child: _buildMessageList()),

          // user Input
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 60, // Adjust height as needed
            child: _buildUserInput(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    final senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatServices.getMessage(senderID, receiverID),
      builder: (context, snapshot) {
        // has Error
        if (snapshot.hasError) {
          return Text('its an error');
        }
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading....');
        }

        log('In the _buildMessageList');
        // return List view
        return ListView(
          reverse: true,
          children: snapshot.data!.docs
              .map((docs) => _buildMessageItem(docs))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot docs) {
    Map<String, dynamic> data = docs.data() as Map<String, dynamic>;

    final isCurrentUser = data['sendId'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            decoration: BoxDecoration(
              color: isCurrentUser ? Colors.green : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
            child: ChatBubble(
              isCurrentUser: isCurrentUser,
              message: data['message'],
              messageID: docs.id,
              userID: data["sendId"],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.green.shade500,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () => sendImage(),
              icon: Icon(
                Icons.image,
                color: Colors.white,
              )),
        ),
        // textfield
        Expanded(
          child: MyTextfield(
              controller: messageController,
              hintText: 'Type Here',
              visibleText: false),
        ),

        const SizedBox(
          width: Tsize.spaceBtwItem,
        ),
        // send Button
        Container(
          decoration: BoxDecoration(
              color: Colors.green.shade500,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
              onPressed: () => sendMessage(),
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
