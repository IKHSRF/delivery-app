import 'package:flutter/material.dart';
import 'package:shop/constant/color.dart';

class Address extends StatelessWidget {
  const Address({
    Key key,
    @required this.screenSize,
    @required this.addressText,
    this.isBottom = false,
  }) : super(key: key);

  final Size screenSize;
  final String addressText;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            addressText,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
            width: 250,
            height: 1,
            color: isBottom ? Colors.white : greyTextColor,
          )
        ],
      ),
    );
  }
}
