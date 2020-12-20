import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';

class GetStarted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15, vertical: screenSize.height * 0.1),
        child: Column(
          children: [
            Text(
              'Food for Everyone',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 55,
                color: Colors.white,
              ),
            ),
            Spacer(),
            SvgPicture.asset(
              'assets/images/women yoga.svg',
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenSize.height * 0.05),
            GestureDetector(
              onTap: () {
                Get.toNamed('/login');
              },
              child: Container(
                alignment: Alignment.center,
                width: screenSize.width,
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Get started',
                  style: TextStyle(
                    color: orangeColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
