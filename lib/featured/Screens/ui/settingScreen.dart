import 'package:chat_app/featured/Screens/ui/blockedUserScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.amber.shade50),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text for Blocked User

                    Text(
                      'Blocked User',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    // Navigation to next Screen
                    IconButton(
                        onPressed: () => Get.to(()=> Blockeduserscreen()),
                        icon: Icon(Icons.arrow_forward_rounded)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
