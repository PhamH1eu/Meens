import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utilities/color.dart';
import './sidebar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: const Sidebar(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.bars),
          color: CustomColors.mainText,
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.magnifyingGlass),
              color: CustomColors.mainText,
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Recommended for you',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: CustomColors.mainText,
                  fontSize: 25,
                  fontFamily: 'Gilroy'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 240,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 30);
                },
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: CustomColors.mainText,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My playlist',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: CustomColors.mainText,
                  fontSize: 25,
                  fontFamily: 'Gilroy'),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 240,
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 30);
                },
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: CustomColors.mainText,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            IconButton(
              icon: const Icon(FontAwesomeIcons.arrowRightFromBracket),
              onPressed: signOut,
            ),
          ],
        ),
      ),
    );
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
