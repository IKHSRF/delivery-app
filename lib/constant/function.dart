import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

String currentUserId = FirebaseAuth.instance.currentUser.uid;
String defaultPhoto = 'https://firebasestorage.googleapis.com/v0/b/shop-de183.appspot.com/o/user%2FphotoDefault.png?alt=media&token=6991c172-aa68-493b-a52f-68b91a186310';
String userUid = FirebaseAuth.instance.currentUser.uid;
String query;

List<String> menuItem = ['Profile', 'History', 'Cart', 'Wishlist'];
List<String> menuIcon = ['assets/icons/user.svg', 'assets/icons/order.svg', 'assets/icons/cart.svg', 'assets/icons/heart.svg'];
List<String> categoryItem = ['All', 'Bakso', 'Cireng', 'Cilor', 'Drinks', 'Others'];
int selectedMenuItem = 0;
int selectedCategory = 0;

setPageTitle() {
  switch (selectedMenuItem) {
    case 0:
      Get.toNamed('/profile');
      break;
    case 1:
      Get.toNamed('/history');
      break;
    case 2:
      Get.toNamed('/cart');
      break;
    case 3:
      Get.toNamed('/wishlist');
      break;
  }
}

setCategoryItem() {
  switch (selectedCategory) {
    case 0:
      query = null;
      break;
    case 1:
      query = 'bakso';
      break;
    case 2:
      query = 'cireng';
      break;
    case 3:
      query = 'cilor';
      break;
    case 4:
      query = 'drinks';
      break;
    case 5:
      query = 'others';
      break;
  }
}
