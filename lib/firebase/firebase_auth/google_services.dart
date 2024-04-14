import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    Future<bool> isNewUser(String email) async {
      QuerySnapshot result = await FirebaseFirestore.instance
          .collection("Users")
          .where("email", isEqualTo: email)
          .get();
      final List<DocumentSnapshot> docs = result.docs;
      return docs.isEmpty ? true : false;
    }

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      if (await isNewUser(value.user!.email!)) {
        final usersRef = FirebaseFirestore.instance.collection('Users');
        usersRef.doc(value.user!.email).set({
          'nickName': value.user!.displayName,
          'firstTime': true,
          'email': value.user!.email,
          'photoUrl': value.user!.photoURL,
        });
      }
      return value;
    });
  }
}
