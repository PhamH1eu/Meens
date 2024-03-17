import 'package:flutter/material.dart';

class PlaylistIntro extends StatelessWidget {
  const PlaylistIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset('assets/playlist.gif', height: 300),
              const SizedBox(height: 20),
              const Text('Create Your Playlist',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const Text(
                  'Craft the perfect soundtrack for every moment. With HarmonyBeat, you can create custom playlists tailored to 	your mood, activity, or genre preferences.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}