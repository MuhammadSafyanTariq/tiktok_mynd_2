import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:insta_clone/utils/colors.dart';

class TextInputFeilds extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final int? maxLines;
  final Function()? onTap;
  const TextInputFeilds(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      this.onTap,
      this.maxLines = 1,
      required this.hintText,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(10),
    );
    return SizedBox(
      // height: 65,
      child: TextField(
        maxLines: maxLines,
        onTap: onTap,
        controller: textEditingController,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: const TextStyle(color: Colors.black26),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: buttonColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: buttonColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: textInputType,
        obscureText: isPass,
      ),
    );
  }
}
