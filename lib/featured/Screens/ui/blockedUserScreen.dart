import 'package:chat_app/featured/Screens/widget/customWidget/user_tile.dart';
import 'package:chat_app/featured/auth/service/auth_service.dart';
import 'package:chat_app/featured/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Blockeduserscreen extends StatelessWidget {
  Blockeduserscreen({
    super.key,
  });

  // final String userID;

  // chat & Auth
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // showing Unblock User
  void _showUnBlockUser(BuildContext context, String userID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('UnBlock User'),
        content: Text('Do you want to unblock user'),
        actions: [
          // cancel BTN
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),

          // UnBlock User
          TextButton(
              onPressed: () {
                _chatServices.unBlockUserID(userID);
                Get.back();
              },
              child: Text('Unblocked')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userID = _authService.getCurrentUser()!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Blocked User List'),
      ),
      body: StreamBuilder(
        stream: _chatServices.getBlockedUser(userID),
        builder: (context, snapshot) {
          // for error
          if (snapshot.hasError) {
            return Text('Somthing is Wrong');
          }

          // for waiting
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading....');
          }

          final blockedUser = snapshot.data ?? [];

          // return List of Blocked User
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final users = blockedUser[index];
              return UserTile(
                title: users['email'],
                onTap: () {
                  _showUnBlockUser(context, users['uid']);
                },
              );
            },
          );
        },
      ),
    );
  }
}
