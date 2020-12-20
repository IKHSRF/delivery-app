import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/constant/function.dart';

class DatabaseServices {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future<String> editAddressDetail(String displayName, String address, String noHp) async {
    try {
      await _firebaseFirestore.collection('users').doc(userUid).update({
        'displayName': displayName,
        'address': address,
        'no_handphone': noHp,
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream<dynamic> getMenuSnapshot(String query) {
    var snapshotCategory = _firebaseFirestore.collection('menus').where('category', isEqualTo: query).snapshots();
    var snapshotAll = _firebaseFirestore.collection('menus').snapshots();

    return (query == null) ? snapshotAll : snapshotCategory;
  }

  static Future<DocumentSnapshot> detailMenu(String menuId) async {
    try {
      var result = await _firebaseFirestore.collection('menus').doc(menuId).get();
      return result;
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream<DocumentSnapshot> getUserWhislist() {
    var result = _firebaseFirestore.collection('users').doc(userUid).snapshots();
    return result;
  }

  static Future<String> addToWishList(String menuId) async {
    try {
      await _firebaseFirestore.collection('users').doc(userUid).update({
        'wishlist': FieldValue.arrayUnion([menuId]),
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> removeFromWishList(String menuId) async {
    try {
      await _firebaseFirestore.collection('users').doc(userUid).update({
        'wishlist': FieldValue.arrayRemove([menuId]),
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Stream<QuerySnapshot> getUserOrder() {
    var result = _firebaseFirestore.collection('orders').where('userUid', isEqualTo: userUid).snapshots();
    return result;
  }

  static Future<String> addToCart(String menuId, num amount) async {
    try {
      await _firebaseFirestore.collection('orders').doc('$menuId$userUid').set({
        'userUid': userUid,
        'orders': menuId,
        'amount': amount,
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> removeFromCart(String menuId) async {
    try {
      await _firebaseFirestore.collection('users').doc(userUid).update({
        'orders': FieldValue.arrayRemove([menuId]),
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }
}
