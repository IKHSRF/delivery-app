import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.snackbar('Sorry', 'feature not yet available', backgroundColor: Colors.red, colorText: Colors.white);
      },
      child: Container(
        width: screenSize.width,
        height: 60,
        padding: EdgeInsets.only(left: 30.0),
        decoration: BoxDecoration(
          color: Color(0xFF7583CA),
          borderRadius: BorderRadius.circular(38),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/facebook logo.svg'),
            SizedBox(width: 30.0),
            Text(
              'CONTINUE WITH FACEBOOK',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
