// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:webtoon/utilities/color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../firebase_auth/google_services.dart';

class SocialLogin extends StatefulWidget {
  const SocialLogin({super.key});

  @override
  State<SocialLogin> createState() => _SocialLoginState();
}

class _SocialLoginState extends State<SocialLogin> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white, // <-- Button color
          ),
          child: Icon(FontAwesomeIcons.facebookF),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () {
            GoogleSignInProvider().signInWithGoogle();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white, // <-- Button color
          ),
          child: Icon(FontAwesomeIcons.google),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            backgroundColor: CustomColors.green,
            foregroundColor: Colors.white, // <-- Button color
          ),
          child: Icon(FontAwesomeIcons.line),
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(15),
            backgroundColor: Colors.blue[200],
            foregroundColor: Colors.white, // <-- Button color
          ),
          child: Icon(FontAwesomeIcons.twitter),
        ),
      ],
    );
  }
}
