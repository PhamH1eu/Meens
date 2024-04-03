// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Error extends StatefulWidget {
  const Error({super.key, required this.error});

  final String error;

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(widget.error,
            style:
                TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Gilroy')),
        SizedBox(height: 10),
      ],
    );
  }
}
