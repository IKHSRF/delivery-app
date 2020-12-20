import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/constant/function.dart';
import 'package:shop/services/firebase_auth_services.dart';

class CutomDrawer extends StatelessWidget {
  const CutomDrawer({
    Key key,
    @required this.screenSize,
  }) : super(key: key);
  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: screenSize.height * 0.2, left: 15.0, bottom: screenSize.height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                itemCount: menuItem.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //navigate another page
                      selectedMenuItem = index;
                      setPageTitle();
                    },
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(menuIcon[index], color: Colors.white),
                              SizedBox(width: 10.0),
                              Text(
                                menuItem[index],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 30.0),
                            width: screenSize.width * 0.3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await AuthServices.firebaseSignOut();
              Get.offAllNamed('/');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    Icons.arrow_right_alt,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
