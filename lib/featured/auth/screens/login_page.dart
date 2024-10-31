import 'package:chat_app/featured/Screens/ui/Home_screen.dart';
import 'package:chat_app/featured/auth/screens/register.dart';
import 'package:chat_app/featured/auth/service/auth_service.dart';
import 'package:chat_app/featured/auth/widget/my_textField.dart';
import 'package:chat_app/core/commonWidget/customBtn/contianer_btn.dart';
import 'package:chat_app/core/utils/constants/Size.dart';
import 'package:chat_app/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  logIn(context) async {
    // get Auth Service
    final _authService = AuthService();
    // try to SignIn
    try {
      await _authService.sigInWithEmailPassword(
          emailController.text, passwordController.text);
      Get.to(() => HomeScreen());
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(error.toString()),
        ),
      );
    }
    // Catch Error
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
                  'Hello Again',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: Tsize.spaceBtwItem),

                // Description
                Text(
                  "Welcome back, you've been missed! ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: TColors.textSecondary),
                ),
                const SizedBox(height: Tsize.spaceBtwSection),

                // Username
                Column(
                  children: [
                    MyTextfield(
                        controller: emailController,
                        hintText: 'email',
                        visibleText: false),
                    const SizedBox(height: Tsize.spaceBtwInputFields),

                    // Password
                    MyTextfield(
                        controller: passwordController,
                        hintText: 'password',
                        visibleText: true),
                  ],
                ),
                const SizedBox(height: Tsize.spaceBtwSection),

                // TextBtn

                CustomBtn(
                  onTap: () => logIn(context),
                  title: 'Login',
                ),

                const SizedBox(height: Tsize.spaceBtwItem),

                // user can login or not
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: Theme.of(context).textTheme.bodySmall!.apply(),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => RegisterPage());
                      },
                      child: Text(
                        'Register Now',
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
