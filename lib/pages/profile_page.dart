import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/constant/function.dart';
import 'package:shop/widgets/edit_address_dialog.dart';
import 'package:shop/widgets/user_address.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    noHpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100],
            padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
            height: screenSize.height * 1.3,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Get.back(),
                    ),
                    Spacer(),
                    Text(
                      'My profile',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                //user profile card
                Container(
                  width: screenSize.width,
                  margin: EdgeInsets.only(top: screenSize.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        width: screenSize.width,
                        height: screenSize.height * 0.15,
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
                                  FirebaseAuth.instance.currentUser.photoURL,
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
                                    FirebaseAuth.instance.currentUser.displayName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    FirebaseAuth.instance.currentUser.email,
                                    style: TextStyle(
                                      color: greyTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //user address
                FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(userUid).get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return Container(
                      width: screenSize.width,
                      margin: EdgeInsets.only(top: screenSize.height * 0.1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address Detail',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              EditAdressDialog(
                                snapshot: snapshot,
                                nameController: nameController,
                                addressController: addressController,
                                noHpController: noHpController,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            padding: EdgeInsets.all(20.0),
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: 30.0, left: 15.0),
                              child: Column(
                                children: [
                                  Address(
                                    screenSize: screenSize,
                                    addressText: snapshot.data['displayName'],
                                  ),
                                  Address(
                                    screenSize: screenSize,
                                    addressText: (snapshot.data['address'] == '') ? 'Alamat Belum Diisi' : snapshot.data['address'],
                                  ),
                                  Address(
                                    screenSize: screenSize,
                                    addressText: (snapshot.data['no_handphone'] == '') ? 'No Handphone Belum Diisi' : snapshot.data['no_handphone'],
                                    isBottom: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
