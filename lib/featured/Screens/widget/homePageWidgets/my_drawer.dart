import 'package:chat_app/core/utils/constants/Size.dart';
import 'package:chat_app/featured/Screens/ui/settingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Logo
            DrawerHeader(
                child: Center(
              child: Icon(
                Icons.message,
                size: 60,
              ),
            )),

            // home List tile

            ListTile(
              onTap: () => Get.back(),
              leading: Icon(Icons.home),
              title: Text(
                'H O M E',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            // Setting List Tile

            ListTile(
              onTap: () => Get.to(() => SettingScreen()),
              leading: Icon(Icons.settings),
              title: Text(
                'S E T T I N G',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            Spacer(),

            // Logout
            ListTile(
              onTap: onTap,
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            const SizedBox(
              height: Tsize.spaceBtwSection,
            )
          ],
        ),
      ),
    );
  }
}
