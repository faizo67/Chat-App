import 'package:chat_app/featured/Screens/ui/Home_screen.dart';
import 'package:chat_app/featured/auth/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user Login go to Home Page
          if (snapshot.hasData) {
            return HomeScreen();
          } 
          // otherwise go to Login Page
          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
