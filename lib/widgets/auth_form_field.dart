import 'package:flutter/material.dart';
import 'package:shop/constant/color.dart';

class AuthFormField extends StatelessWidget {
  const AuthFormField({
    Key key,
    @required this.screenSize,
    @required this.hintText,
    @required this.textController,
    @required this.inputType,
    this.isPassword = false,
  }) : super(key: key);

  final Size screenSize;
  final String hintText;
  final bool isPassword;
  final TextEditingController textController;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        keyboardType: inputType,
        obscureText: isPassword,
        controller: textController,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(color: greyTextColor),
        ),
      ),
    );
  }
}
