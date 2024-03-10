import 'package:flutter/material.dart';

import '../model/playlist.dart';
import '../model/song.dart';
import '../utilities/color.dart';
import 'widgets/playlist_info.dart';
import 'widgets/song_info.dart';

Song song = Song(
    title: "Whatever It Takes",
    artist: "IMAGINE DRAGONS",
    artWork: "assets/artwork.jpg");
Playlist playlist = Playlist(title: "Evolve", artwork: "assets/album.jpg");

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
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
                itemBuilder: (context, index) => SongInfo(song: song),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Playlist',
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
                itemBuilder: (context, index) =>
                    PlaylistInfo(playlist: playlist),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
