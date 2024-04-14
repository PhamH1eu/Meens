import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webtoon/screen/onboard/widget/genres_screen.dart';
import 'package:webtoon/screen/onboard/widget/intro.dart';

import 'widget/own_playlist.dart';
import 'widget/personalized_recommend.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController();
  HashSet<String> selectedGenres = HashSet();
  bool isLastPage = false;

  Future<void> done() async {
    final userRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.email);
    userRef.update({'genres': selectedGenres.toList(), 'firstTime': false}).then(
        (value) => log("DocumentSnapshot successfully updated!"),
        onError: (e) => log("Error updating document $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) => setState(() {
            isLastPage = value == 3;
          }),
          children: [
            const Intro(),
            const PlaylistIntro(),
            const PersonalizRec(),
            GenresPage(
              selectedGenres: selectedGenres,
            )
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.jumpToPage(3);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[500],
                  ),
                  child:
                      const Text('Skip', style: TextStyle(color: Colors.white)),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: ExpandingDotsEffect(
                      dotColor: Colors.blue[200]!,
                      activeDotColor: Colors.blue[600]!),
                ),
                isLastPage
                    ? ElevatedButton(
                        onPressed: () async {
                          done();
                          if (context.mounted) {
                            Navigator.pushNamed(context, '/home');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[500],
                        ),
                        child: const Text('Done',
                            style: TextStyle(color: Colors.white)),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[500],
                        ),
                        child: const Text('Next',
                            style: TextStyle(color: Colors.white)),
                      ),
              ],
            ))
      ]),
    );
  }
}
