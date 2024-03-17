import 'package:flutter/material.dart';

import '../model/playlist.dart';
import '../model/song.dart';
import '../utilities/fonts.dart';
import 'widgets/playlist_info.dart';
import 'widgets/song_info.dart';

const Song song = Song(
    title: "Whatever It Takes",
    artist: "IMAGINE DRAGONS",
    artWork: "assets/artwork.jpg");
const Playlist playlist =
    Playlist(title: "Evolve", artwork: "assets/album.jpg");

//App is lagging because async run when HomeUI rebuilt => reinsert ListView.builder => reinsert Widget

class HomeUI extends StatelessWidget {
  const HomeUI({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Text(
              'Recommended for you',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: Theme.of(context).primaryColor,
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
                itemBuilder: (context, index) => const SongInfo(song: song),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'My Playlist',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: Theme.of(context).primaryColor,
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
                    const PlaylistInfo(playlist: playlist),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
