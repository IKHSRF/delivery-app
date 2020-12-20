import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/services/firestore_services.dart';
import 'package:shop/widgets/empty_item_page.dart';
import 'package:shop/widgets/menu_card.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseServices.getUserOrder(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.data.docs.length == 0) {
                return EmptyItemPage(screenSize: screenSize, pageTitle: 'Orders', imagePath: '');
              }
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: Column(
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
                            'Orders',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Container(
                        height: screenSize.height,
                        child: ListView.builder(
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            return MenuCard(
                              screenSize: screenSize,
                              menuItem: snapshot.data.docs[index]['orders'],
                              documentType: 'orders',
                              amount: snapshot.data.docs[index]['amount'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
