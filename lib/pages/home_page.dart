import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/constant/function.dart';
import 'package:shop/services/firestore_services.dart';
import 'package:shop/widgets/category.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/item_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool sidebarOpen = false;
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  void setSidebarState() {
    setState(() {
      xOffset = sidebarOpen ? 200 : 0;
      yOffset = sidebarOpen ? 130 : 0;
      scaleFactor = sidebarOpen ? 0.7 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: orangeColor,
      body: SafeArea(
        child: Stack(
          children: [
            CutomDrawer(
              screenSize: screenSize,
            ),
            Container(
              transform: Matrix4.translationValues(180, 170, 0)..scale(0.7),
              height: screenSize.height * 0.93,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            AnimatedContainer(
              curve: Curves.easeInOut,
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: sidebarOpen ? BorderRadius.circular(30.0) : null,
              ),
              transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
              duration: Duration(milliseconds: 250),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            sidebarOpen = !sidebarOpen;
                            setSidebarState();
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/menu.svg',
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/cart');
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/cart.svg',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
                    child: Text(
                      'Delicious\nfood for you',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        hintStyle: TextStyle(color: greyTextColor),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 0),
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryItem.length,
                      itemBuilder: (context, index) {
                        return CategoryMenu(
                          selected: selectedCategory,
                          position: index,
                          categoryItem: categoryItem[index],
                          categoryPressed: () {
                            setState(() {
                              selectedCategory = index;
                            });
                            setCategoryItem();
                          },
                        );
                      },
                    ),
                  ),
                  StreamBuilder(
                    stream: DatabaseServices.getMenuSnapshot(query),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      return Container(
                        width: screenSize.width,
                        height: screenSize.height * 0.55,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              screenSize: screenSize,
                              itemName: snapshot.data.docs[index]['menu_name'],
                              itemPrice: snapshot.data.docs[index]['price'].toString(),
                              imagePath: snapshot.data.docs[index]['picture'],
                              buttonPress: () {
                                Get.toNamed('/detail', arguments: snapshot.data.docs[index].id);
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
