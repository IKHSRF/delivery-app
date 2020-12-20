import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/pages/get_started_page.dart';
import 'package:shop/pages/home_page.dart';

class UserValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseuser = Provider.of<User>(context);
    return (firebaseuser == null) ? GetStarted() : HomePage();
  }
}
