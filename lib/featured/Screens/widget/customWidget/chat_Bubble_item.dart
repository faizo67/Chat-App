import 'package:chat_app/core/utils/constants/Size.dart';
import 'package:chat_app/featured/services/chat/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageID;
  final String userID;

  const ChatBubble(
      {super.key,
      required this.isCurrentUser,
      required this.message,
      required this.messageID,
      required this.userID});

  // showOption
  void _showOptions(context, String messageID, String userId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            // report User Btn
            ListTile(
              leading: Icon(Icons.flag),
              title: Text(
                'Report',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.back();
                _reportContent(messageID, userId, context);
              },
            ),
            const SizedBox(height: Tsize.spaceBtwItem),

            // Block User Btn
            ListTile(
              leading: Icon(Icons.block),
              title: Text(
                'Block',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.back();
                _blockUser(userId, context);
              },
            ),
            const SizedBox(height: Tsize.spaceBtwItem),

            // Cancel Btn
            ListTile(
              leading: Icon(Icons.cancel),
              title: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.back();
              },
            ),
            const SizedBox(height: Tsize.spaceBtwSection),
          ],
        ));
      },
    );
  }

  // report
  void _reportContent(String messageID, String userID, context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reporter"),
        content: Text("Are you Sure Do you Want to report this message"),
        actions: [
          // Cancel Btn
          TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
          // Report Btn
          TextButton(
              onPressed: () {
                ChatServices().reportUser(messageID, userID);
                Get.back();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Message Reported")));
              },
              child: Text("Report User")),
        ],
      ),
    );
  }

  // block User
  void _blockUser(String userID, context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Block Content"),
        content: Text("Are you Sure Do you Want to report this message"),
        actions: [
          // Cancel Btn
          TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
          // Report Btn
          TextButton(
              onPressed: () {
                ChatServices().blockUser(userID);
                Get.back();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("User Blocked")));
              },
              child: Text("Block User")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // ShowOptions
        _showOptions(context, messageID, userID);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey,
        ),
        child: Text(message),
      ),
    );
  }
}
