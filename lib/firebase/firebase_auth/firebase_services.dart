import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String errorMessage = "";

  User? get currentUser => _auth.currentUser;

  void _createNewUserInFirestore(String nickname) async {
    final User? user = currentUser;
    final usersRef = FirebaseFirestore.instance.collection('Users');
    usersRef.doc(user?.email).set({
      'nickName': nickname,
      'email': user?.email,
      'firstTime': true,
      'photoUrl':
          "https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/avatar%2Fuser.jpg?alt=media&token=46c6a002-45d2-4003-a77b-bbdb4c966186",
    });
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String nickName) async {
    try {
      errorMessage = "";
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _createNewUserInFirestore(nickName);
      return credential.user;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "network-request-failed":
          errorMessage = "No internet connection. Please try again.";
          break;
        case "email-already-in-use":
          errorMessage = "Your email address has been used before.";
          break;
        case "invalid-email":
          errorMessage = "Your email address is not valid";
          break;
        case "weak-password":
          errorMessage = "Your password need at least 6 characters.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      errorMessage = "";
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "network-request-failed":
          errorMessage = "No internet connection. Please try again.";
          break;
        case "invalid-email":
          errorMessage = "Your email address isn't in correct format.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "channel-error":
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
    }
    return null;
  }
}
