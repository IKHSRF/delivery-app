import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'orange_button.dart';

class EmptyItemPage extends StatelessWidget {
  const EmptyItemPage({
    Key key,
    @required this.screenSize,
    @required this.pageTitle,
    @required this.imagePath,
  }) : super(key: key);

  final Size screenSize;
  final String pageTitle;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.back();
                },
              ),
              SizedBox(width: screenSize.width * 0.22),
              Text(
                pageTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
            ],
          ),
          Container(
            child: Column(
              children: [
                (imagePath.isEmpty || imagePath == '') ? Container() : SvgPicture.asset(imagePath),
                SizedBox(height: 10.0),
                Text(
                  'No $pageTitle yet',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Hit the orange button\ndown below to Create an order',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
          OrangeButton(
            screenSize: screenSize,
            buttonText: 'Start Ordering',
            buttonPress: () {
              Get.toNamed('/home');
            },
          )
        ],
      ),
    );
  }
}
