import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/constant/color.dart';
import 'package:shop/services/firestore_services.dart';

class EditAdressDialog extends StatelessWidget {
  const EditAdressDialog({
    Key key,
    @required this.nameController,
    @required this.addressController,
    @required this.noHpController,
    @required this.snapshot,
  }) : super(key: key);

  final snapshot;
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController noHpController;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Get.defaultDialog(
          title: 'Edit Address',
          actions: [
            GestureDetector(
              onTap: () async {
                String result = await DatabaseServices.editAddressDetail(
                  (nameController.text.isEmpty) ? snapshot.data['displayName'] : nameController.text,
                  (addressController.text.isEmpty) ? snapshot.data['address'] : addressController.text,
                  (noHpController.text.isEmpty) ? snapshot.data['no_handphone'] : noHpController.text,
                );
                if (result != 'berhasil') {
                  Get.snackbar('Oops Something wrong', result);
                } else {
                  nameController.clear();
                  addressController.clear();
                  noHpController.clear();
                  Get.back();
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: 20.0),
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: orangeColor,
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
          content: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: snapshot.data['displayName'],
                  ),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: (snapshot.data['address'] == '') ? 'Alamat Lengkap' : snapshot.data['address'],
                  ),
                ),
                TextField(
                  controller: noHpController,
                  decoration: InputDecoration(
                    hintText: (snapshot.data['no_handphone'] == '') ? 'No Telepon' : snapshot.data['no_handphone'],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
