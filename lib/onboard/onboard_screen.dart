import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webtoon/onboard/widget/genres_screen.dart';
import 'package:webtoon/onboard/widget/intro.dart';

import 'widget/own_playlist.dart';
import 'widget/personalized_recommend.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _controller = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (value) => setState(() {
            isLastPage = value == 3;
          }),
          children: const [
            Intro(),
            PlaylistIntro(),
            PersonalizRec(),
            GenresPage()
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
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isFirstTime', false);
                          if (mounted) Navigator.pushNamed(context, '/home');
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
