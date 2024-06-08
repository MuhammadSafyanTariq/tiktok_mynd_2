import 'package:flutter/material.dart';
import 'package:insta_clone/utils/colors.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool backButton;
  const MyAppBar({super.key, required this.title, required this.backButton});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 55, 0, 12),
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5)],
        color: buttonColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      width: double.infinity,
      height: height * 15,
      child: backButton
          ? Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                Spacer(),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Spacer(),
              ],
            )
          : Center(
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
    );
  }
}
