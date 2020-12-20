import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop/constant/function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static GoogleSignIn _googleSignIn = GoogleSignIn();
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  static Future<String> loginWithGoogle() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      await _firebaseFirestore.collection('users').doc(_firebaseAuth.currentUser.uid).set({
        'displayName': _firebaseAuth.currentUser.displayName,
        'address': '',
        'no_handphone': '',
        'wishlist': [],
        'orders': [],
        'history': [],
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> loginWithEmailandPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<String> signUpWithEmailandPassword(String email, String password, String name) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firebaseAuth.currentUser.updateProfile(displayName: name, photoURL: defaultPhoto);
      await _firebaseFirestore.collection('users').doc(_firebaseAuth.currentUser.uid).set({
        'displayName': _firebaseAuth.currentUser.displayName,
        'address': '',
        'no_handphone': '',
        'wishlist': [],
        'orders': [],
        'history': [],
      });
      return 'berhasil';
    } catch (error) {
      print(error);
      return error.message;
    }
  }

  static Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  static Future<void> firebaseSignOut() async {
    await _firebaseAuth.signOut();
  }

  static Stream<User> get firebaseUserStream => _firebaseAuth.authStateChanges();
}
