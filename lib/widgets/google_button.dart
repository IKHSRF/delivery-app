import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/services/firebase_auth_services.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    Key key,
    @required this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String result = await AuthServices.loginWithGoogle();
        if (result != 'berhasil') {
          Get.snackbar('Oops something went wrong', result, backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.offAllNamed('/home');
        }
      },
      child: Container(
        width: screenSize.width,
        height: 60,
        padding: EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(38),
          border: Border.all(color: greyColor, width: 3),
        ),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/google logo.svg'),
            SizedBox(width: 30.0),
            Text(
              'CONTINUE WITH GOOGLE',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
