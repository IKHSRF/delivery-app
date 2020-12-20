import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/services/firestore_services.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({
    Key key,
    @required this.screenSize,
    @required this.menuItem,
    @required this.documentType,
    this.amount,
  }) : super(key: key);

  final Size screenSize;
  final String documentType;
  final menuItem;
  final int amount;

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int menuAmount = 0;
  @override
  Widget build(BuildContext context) {
    menuAmount = widget.amount;
    String menuItem = widget.menuItem;
    return FutureBuilder(
      future: DatabaseServices.detailMenu(menuItem),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/detail', arguments: snapshot.data.id);
            },
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              width: widget.screenSize.width,
              height: widget.screenSize.height * 0.17,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.network(
                        snapshot.data['picture'],
                        width: 80.0,
                        height: 80.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data['menu_name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Rp ${snapshot.data['price'].toString()}',
                          style: TextStyle(
                            color: orangeColor,
                          ),
                        ),
                        (widget.documentType == 'orders')
                            ? Container(
                                child: Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove,
                                        color: orangeColor,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          menuAmount -= 1;
                                        });
                                        var result = await DatabaseServices.addToCart(menuItem, menuAmount);
                                        if (result != 'berhasil') {
                                          print('berhasil');
                                        }
                                      },
                                    ),
                                    Text(menuAmount.toString()),
                                    IconButton(
                                      icon: Icon(Icons.add, color: orangeColor),
                                      onPressed: () async {
                                        setState(() {
                                          menuAmount += 1;
                                        });
                                        var result = await DatabaseServices.addToCart(menuItem, menuAmount);
                                        if (result != 'berhasil') {
                                          print('berhasil');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: widget.documentType == 'history'
                          ? null
                          : IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                String result;
                                if (widget.documentType == 'wishlist') {
                                  result = await DatabaseServices.removeFromWishList(snapshot.data.id);
                                } else {
                                  result = await DatabaseServices.removeFromCart(snapshot.data.id);
                                }
                                if (result != 'berhasil') {
                                  Get.snackbar('Oops something went wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                                }
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
