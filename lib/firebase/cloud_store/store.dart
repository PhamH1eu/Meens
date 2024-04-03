import 'package:firebase_storage/firebase_storage.dart';

final storage = FirebaseStorage.instance;

final storageRef = FirebaseStorage.instance.ref();

final coldPlayRef = storageRef.child('artists/coldplay.jpg');

final coldPlayUrl = coldPlayRef.getDownloadURL();

//testing
