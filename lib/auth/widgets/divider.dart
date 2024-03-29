// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:webtoon/utilities/fonts.dart';

class DividerLine extends StatefulWidget {
  const DividerLine({super.key});

  @override
  State<DividerLine> createState() => _DividerLineState();
}

class _DividerLineState extends State<DividerLine> {
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: Divider(
              color: Theme.of(context).secondaryHeaderColor,
              height: 9,
            )),
      ),
      Text(
        "OR Login with",
        style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).secondaryHeaderColor,
            fontFamily: 'Gilroy',
            fontWeight: CustomColors.regular),
      ),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 20.0, right: 10.0),
            child: Divider(
              color: Theme.of(context).secondaryHeaderColor,
              height: 9,
            )),
      ),
    ]);
  }
}
