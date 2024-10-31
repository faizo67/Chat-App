import 'package:chat_app/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTile extends StatelessWidget {
  UserTile({super.key, required this.title, required this.onTap});
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: TColors.accent,
          ),
          child: Row(
            children: [
              // Logo
              Icon(Icons.person),
              const SizedBox(
                width: 25,
              ),
              // username
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
