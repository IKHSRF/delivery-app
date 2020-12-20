import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/services/firebase_auth_services.dart';
import 'package:shop/widgets/auth_form_field.dart';
import 'package:shop/widgets/facebook_button.dart';
import 'package:shop/widgets/google_button.dart';
import 'package:shop/widgets/orange_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          child: SingleChildScrollView(
            child: Container(
              width: screenSize.width,
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: screenSize.height * 0.03),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: greyColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.04),
                    alignment: Alignment.center,
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FacebookButton(
                    screenSize: screenSize,
                  ),
                  SizedBox(height: screenSize.height * 0.015),
                  GoogleButton(
                    screenSize: screenSize,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: screenSize.height * 0.04, top: screenSize.height * 0.03),
                    alignment: Alignment.center,
                    child: Text(
                      'OR LOG IN WITH EMAIL',
                      style: TextStyle(
                        color: greyTextColor,
                      ),
                    ),
                  ),
                  AuthFormField(
                    inputType: TextInputType.emailAddress,
                    screenSize: screenSize,
                    hintText: 'Email address',
                    textController: emailController,
                  ),
                  AuthFormField(
                    inputType: TextInputType.text,
                    isPassword: true,
                    screenSize: screenSize,
                    hintText: 'Password',
                    textController: passwordController,
                  ),
                  SizedBox(height: screenSize.height * 0.04),
                  OrangeButton(
                    screenSize: screenSize,
                    buttonText: 'Login',
                    buttonPress: () async {
                      setState(() {
                        isLoading = true;
                      });
                      String result = await AuthServices.loginWithEmailandPassword(emailController.text, passwordController.text);
                      if (result != 'berhasil') {
                        setState(() {
                          isLoading = false;
                        });
                        Get.snackbar('Oops Something went wrong', result, colorText: Colors.white, backgroundColor: Colors.red);
                      } else {
                        Get.toNamed('/home');
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: screenSize.height * 0.16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ALREADY HAVE AN ACCOUNT? '),
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/register');
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(color: orangeColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
