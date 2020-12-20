import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop/constant/color.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key key,
    @required this.screenSize,
    @required this.itemName,
    @required this.itemPrice,
    @required this.imagePath,
    @required this.buttonPress,
  }) : super(key: key);

  final Size screenSize;
  final String itemName;
  final String itemPrice;
  final String imagePath;
  final Function buttonPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonPress,
      child: Container(
        margin: EdgeInsets.only(top: 100, left: 15.0),
        height: screenSize.height * 0.4,
        width: screenSize.width * 0.55,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: screenSize.width * 0.55,
              height: screenSize.height * 0.37,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 10,
              top: -60,
              child: Container(
                padding: EdgeInsets.all(10),
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  // child: Image.network(
                  //   imagePath,
                  //   fit: BoxFit.cover,
                  // ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: imagePath,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: -100,
              child: Container(
                padding: EdgeInsets.all(10),
                height: screenSize.height * 0.3,
                width: screenSize.width * 0.5,
                child: Column(
                  children: [
                    Text(
                      itemName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Rp $itemPrice',
                      style: TextStyle(
                        color: orangeColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
