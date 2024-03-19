import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShazamResult extends StatelessWidget {
  const ShazamResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.xmark),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.arrowUpFromBracket),
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(FontAwesomeIcons.ellipsisVertical),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/shazam.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black, Colors.black54, Colors.transparent],
                ),
              ),
              alignment: const Alignment(0, 0.75),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Animate(
                      effects: const [
                        SlideEffect(
                            begin: Offset(0, 1),
                            end: Offset(0, 0),
                            duration: Duration(milliseconds: 400)),
                      ],
                      child: const Text(
                        'Atlantis (Extra Sped Up Version)',
                        style: TextStyle(
                            color: Color.fromRGBO(234, 240, 255, 1),
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Animate(
                      effects: const [
                        SlideEffect(
                            begin: Offset(0, 1),
                            end: Offset(0, 0),
                            delay: Duration(
                              milliseconds: 100,
                            ),
                            duration: Duration(milliseconds: 500)),
                      ],
                      child: const Text(
                        'Seafret',
                        style: TextStyle(
                            color: Color.fromRGBO(234, 240, 255, 1),
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
