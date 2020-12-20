import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/detail_page.dart';
import 'package:shop/pages/login_page.dart';
import 'package:shop/pages/home_page.dart';
import 'package:shop/pages/profile_page.dart';
import 'package:shop/pages/wishlist_page.dart';
import 'package:shop/services/firebase_auth_services.dart';
import 'package:shop/services/user_validation.dart';

import 'pages/cart_page.dart';
import 'pages/register_page.dart';
import 'pages/get_started_page.dart';
import 'pages/history_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SF Pro Rounded',
        ),
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => UserValidation(),
          ),
          GetPage(
            name: '/getstarted',
            page: () => GetStarted(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginPage(),
          ),
          GetPage(
            name: '/register',
            page: () => RegisterPage(),
          ),
          GetPage(
            name: '/home',
            page: () => HomePage(),
          ),
          GetPage(
            name: '/cart',
            page: () => CartPage(),
          ),
          GetPage(
            name: '/history',
            page: () => HistoryPage(),
          ),
          GetPage(
            name: '/wishlist',
            page: () => WishListPage(),
          ),
          GetPage(
            name: '/profile',
            page: () => ProfilePage(),
          ),
          GetPage(
            name: '/detail',
            page: () => DetailPage(),
          ),
        ],
      ),
    );
  }
}
