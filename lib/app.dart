import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Hind'),
      home: Column(
        children: <Widget>[
          const Text('Hello World'),
          IconButton(
            icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            onPressed: signOut,
          ),
        ],
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}