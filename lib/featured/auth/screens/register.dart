import 'package:chat_app/featured/Screens/ui/Home_screen.dart';
import 'package:chat_app/featured/auth/screens/login_page.dart';
import 'package:chat_app/featured/auth/service/auth_service.dart';
import 'package:chat_app/featured/auth/widget/my_textField.dart';
import 'package:chat_app/core/commonWidget/customBtn/contianer_btn.dart';
import 'package:chat_app/core/utils/constants/Size.dart';
import 'package:chat_app/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void registerUser(context) {
    final AuthService auth = AuthService();
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      try {
        auth.signUpWithEmailPassword(
            emailController.text, passwordController.text);
        Get.to(() => LoginPage());
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Succesful"),
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Don't Match Password"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.message,
                  size: Tsize.defaultSpace * 4,
                ),
                const SizedBox(
                  height: Tsize.spaceBtwItem - 10,
                ),
                // Hello Text
                Text(
                  'Simply Register',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: Tsize.spaceBtwItem),

                // Description
                Text(
                  "By follow you can Register",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: TColors.textSecondary),
                ),
                const SizedBox(height: Tsize.spaceBtwSection),

                // Email
                Column(
                  children: [
                    MyTextfield(
                        controller: emailController,
                        hintText: 'Email',
                        visibleText: false),
                    const SizedBox(height: Tsize.spaceBtwInputFields),

                    // Password
                    MyTextfield(
                        controller: passwordController,
                        hintText: 'password',
                        visibleText: true),
                    const SizedBox(height: Tsize.spaceBtwInputFields),

                    MyTextfield(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        visibleText: true),
                  ],
                ),
                const SizedBox(height: Tsize.spaceBtwSection),

                // TextBtn
                MaterialButton(
                  onPressed: () => registerUser(context),
                  child: CustomBtn(
                    title: 'Register',
                  ),
                ),

                const SizedBox(height: Tsize.spaceBtwItem),

                // user can login or not
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: Theme.of(context).textTheme.bodySmall!.apply(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => LoginPage());
                      },
                      child: Text(
                        'Login Now',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .apply(color: TColors.btnPrimary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
