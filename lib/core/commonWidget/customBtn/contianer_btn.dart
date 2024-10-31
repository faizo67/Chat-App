import 'package:flutter/material.dart';
import 'package:chat_app/core/utils/constants/colors.dart';

// ignore: must_be_immutable
class CustomBtn extends StatelessWidget {
  CustomBtn({super.key, required this.title, this.onTap});
  String title;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: TColors.btnPrimary,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
