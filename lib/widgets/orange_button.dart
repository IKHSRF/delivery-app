import 'package:flutter/material.dart';
import 'package:shop/constant/color.dart';

class OrangeButton extends StatelessWidget {
  const OrangeButton({
    Key key,
    @required this.screenSize,
    @required this.buttonText,
    @required this.buttonPress,
  }) : super(key: key);

  final Size screenSize;
  final String buttonText;
  final Function buttonPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonPress,
      child: Container(
        alignment: Alignment.center,
        width: screenSize.width,
        height: 55,
        decoration: BoxDecoration(
          color: orangeColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
      ),
    );
  }
}
