import 'dart:developer';
import 'package:chat_app/featured/Screens/ui/chat_screen.dart';
import 'package:chat_app/featured/Screens/widget/customWidget/user_tile.dart';
import 'package:chat_app/featured/Screens/widget/homePageWidgets/my_drawer.dart';
import 'package:chat_app/featured/auth/service/auth_service.dart';
import 'package:chat_app/featured/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // chat & Auth
  final ChatServices _chatServices = ChatServices();
  final AuthService _authService = AuthService();

  // LogOut Method
  void logOut() {
    // final AuthService authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Page',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: logOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),
      drawer: MyDrawer(
        onTap: () => logOut(),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.allUsersExceptBlockedStream(),
      builder: (context, snapshot) {
        // for Error
        if (snapshot.hasError) {
          return Text('Error');
        }

        // Loading
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        log('After Loading');
        // return List
        return ListView(
          children: snapshot.data!.map<Widget>(
            (userData) {
              return _buildUserItem(userData, context);
            },
          ).toList(),
        );
      },
    );
  }

  Widget _buildUserItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        title: userData['email'],
        onTap: () => Get.to(() => ChatScreen(
              receiverName: userData['email'],
              receiverID: userData['uid'],
            )),
      );
    } else {
      return Container();
    }
  }
}
