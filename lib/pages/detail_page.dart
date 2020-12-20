import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/constant/function.dart';
import 'package:shop/services/firestore_services.dart';
import 'package:shop/widgets/information_detail.dart';
import 'package:shop/widgets/orange_button.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  String menuId = Get.arguments;
  var userFavorites = [];
  var user;
  void getUserFavorite() async {
    user = await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    setState(() {
      // ambil id dari argument yang di pass page sebelumnya
      userFavorites = user.data()['wishlist'];
      if (userFavorites.contains(menuId)) {
        isFavorite = true;
      } else {
        isFavorite = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserFavorite();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: DatabaseServices.detailMenu(Get.arguments),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                height: screenSize.height,
                width: screenSize.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Stack(
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  child: Image.network(
                    snapshot.data['picture'],
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenSize.height * 0.4),
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        snapshot.data['menu_name'],
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Rp ${snapshot.data['price'].toString()}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: orangeColor,
                        ),
                      ),
                    ),
                    InformationDetail(
                      screenSize: screenSize,
                      infoTitle: 'Delivery Info',
                      infoContent: 'Delivered between monday and thursday from 8pm to 91:32 pm',
                    ),
                    InformationDetail(
                      screenSize: screenSize,
                      infoTitle: 'Return policy',
                      infoContent: 'All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.',
                    ),
                    Padding(
                      padding: EdgeInsets.all(40.0),
                      child: OrangeButton(
                        screenSize: screenSize,
                        buttonText: 'Add to Cart',
                        buttonPress: () async {
                          // ambil id dari argument yang di pass page sebelumnya
                          String result = await DatabaseServices.addToCart(menuId, 1);
                          if (result != 'berhasil') {
                            Get.snackbar('Oops something when wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                          } else {
                            Get.snackbar('Success', 'Success add item to cart', colorText: Colors.white, backgroundColor: Colors.green);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height * 0.4,
                  color: Colors.black.withOpacity(0.1),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.back(),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: () async {
                          // ambil id dari argument yang di pass page sebelumnya
                          if (isFavorite == false) {
                            var result = await DatabaseServices.addToWishList(Get.arguments);
                            if (result != 'berhasil') {
                              Get.snackbar('Oops something when wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                            }
                            setState(() {
                              isFavorite = true;
                            });
                          } else {
                            var result = await DatabaseServices.removeFromWishList(Get.arguments);
                            if (result != 'berhasil') {
                              Get.snackbar('Oops something when wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                            }
                            setState(() {
                              isFavorite = false;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
