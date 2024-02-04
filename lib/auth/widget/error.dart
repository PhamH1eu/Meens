// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:webtoon/utilities/color.dart';

class Error extends StatefulWidget {
  const Error({super.key});

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: const <Widget>[
          Text("The email address you have entered has not been registered", style: TextStyle(color: CustomColors.gray)),
          SizedBox(height: 10),
        ],
    );
  }
}