import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webtoon/recognition/recent.dart';

class Shazam extends StatefulWidget {
  const Shazam({super.key});

  @override
  State<Shazam> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Shazam> {
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(55, 140, 231, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tap to recognize your song',
                style: TextStyle(
                    color: Color.fromRGBO(247, 250, 255, 1), fontSize: 27),
              ),
              const SizedBox(
                height: 60,
              ),
              AvatarGlow(
                  glowCount: 3,
                  duration: const Duration(milliseconds: 1300),
                  animate: isListening,
                  glowRadiusFactor: 0.5,
                  glowColor: const Color.fromRGBO(247, 250, 255, 1),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isListening = !isListening;
                      });
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      padding: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Color.fromRGBO(99, 174, 255, 1),
                        color: Color.fromRGBO(247, 250, 255, 1),
                      ),
                      // child: Image.asset('assets/shazam.png'),
                      child: Image.asset('assets/icon.png'),
                    ),
                  )),
              IconButton(
                  onPressed: () => Navigator.of(context).pushNamed('/result'),
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ))
            ],
          ),
        ),
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          panel: const Recent(),
        ),
      ]),
    );
  }
}
