// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:webtoon/color.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({super.key});

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width / 2 - 20,
          child: Text('Sign up or log in to enjoy free comics.',
              style: TextStyle(
                color: CustomColors.white,
                fontSize: 16,
              )),
        ),
        Image.asset(
          'assets/banner.gif',
          width: MediaQuery.of(context).size.width / 2 - 20,
        ),
      ],
    );
  }
}
