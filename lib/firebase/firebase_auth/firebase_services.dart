import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String errorMessage = "";
  final FirebaseStorage _storage = FirebaseStorage.instance;
  User? get currentUser => _auth.currentUser;

  Future<String> uploadImageToStorage(String childName,Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl+"jpgggg");
    return downloadUrl;
  }

  void _createNewUserInFirestore(String nickname,Uint8List file) async {
    final User? user = currentUser;
    try{
      if(nickname.isNotEmpty || file.isNotEmpty) {
        final usersRef = FirebaseFirestore.instance.collection('Users');
        String randomPath = Uuid().v4() as String;
        String path = "avatar/" +randomPath +".jpg";
        String imageUrl = await uploadImageToStorage(path, file);
        usersRef.doc(user?.email).set({
          'nickName': nickname,
          'email': user?.email,
          'firstTime': true,
          'photoUrl': imageUrl,
        });
      }
    }
    catch(err){
      print(err.toString());
    }
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String nickName,Uint8List file) async {
    try {
      errorMessage = "";
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _createNewUserInFirestore(nickName,file);
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
