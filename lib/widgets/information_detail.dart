import 'package:flutter/material.dart';
import 'package:shop/constant/color.dart';

class InformationDetail extends StatelessWidget {
  const InformationDetail({
    Key key,
    @required this.screenSize,
    @required this.infoTitle,
    @required this.infoContent,
  }) : super(key: key);

  final Size screenSize;
  final String infoTitle;
  final String infoContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20.0, left: 20.0),
          child: Text(
            infoTitle,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: screenSize.width * 0.1),
          child: Text(
            infoContent,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              color: greyTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
