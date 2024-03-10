import 'package:flutter/material.dart';

import 'package:miniplayer/miniplayer.dart';
import 'play_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Miniplayer(
      minHeight: 60,
      maxHeight: MediaQuery.of(context).size.height,
      builder: (height, percentage) {
        if (height <= 60) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: const Center(
              child: Text('Miniplayer'),
            ),
          );
        }
        //test thoi
        return const PlayingScreen();
      },
    );
  }
}