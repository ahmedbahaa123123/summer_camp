import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:summer_camp/utills/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authChanges => _auth.authStateChanges();
  User? get user => _auth.currentUser;

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Save user data to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': userCredential.user!.email,
        'uid': userCredential.user!.uid,
        'username': userCredential.user!.displayName ?? '',
      });

      return userCredential.user;
    } catch (e) {
      ShowSnackBar(context, e.toString());
      return null;
    }
  }

  Future<bool> signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user != null;
    } catch (e) {
      ShowSnackBar(context, e.toString());
      return false;
    }
  }

  Future<bool> signUp(String email, String password, String username, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': userCredential.user!.uid,
        'username': username,
      });

      return true;
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context, e.message!);
      return false;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      throw Exception("No user logged in");
    } else {
      return await _firestore.collection("users").doc(currentUser.uid).get();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
