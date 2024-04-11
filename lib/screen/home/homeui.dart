import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webtoon/firebase/cloud_store/store.dart';

import '../../model/playlist.dart';
import '../../model/song.dart';
import '../../utilities/fonts.dart';
import 'widgets/playlist_info.dart';
import 'widgets/song_info.dart';

const Playlist playlist =
    Playlist(title: "Evolve", artwork: "assets/album.jpg");
Song song = Song(
    title: "Viva La Vida",
    artist: "Coldplay",
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fcoldplay.jpg?alt=media&token=4c15b070-dac9-4532-b340-fee903c3e821',
    songPath:
        'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fvivalavida.mp3?alt=media&token=4b30c354-4086-4a67-9735-3b99ae7c9293');

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  final List<Song> songs = [];
  bool isLoading = true;
  final Stream<QuerySnapshot> songStream = FirebaseFirestore.instance
      .collection('Songs')
      .where('genres', arrayContains: 'Pop')
      .snapshots();

  @override
  void initState() {
    super.initState();
  }

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
              child: StreamBuilder<QuerySnapshot>(
                stream: songStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Future.wait(snapshot.data!.docs.map((e) async {
                      log(e.metadata.isFromCache.toString());
                      String name = e['title'];
                      String imageUrl = await Storage.getSongAvatarUrl(name);
                      String songUrl = await Storage.getSongUrl(name);
                      return Song.fromJson(e.data(), imageUrl, songUrl);
                    }).toList())
                        .then((value) {
                      if (context.mounted) {
                        setState(() {
                          songs.clear();
                          songs.addAll(value);
                          isLoading = false;
                        });
                      }
                    });

                    return isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : SizedBox(
                            height: 240,
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(width: 30);
                              },
                              itemCount: songs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  SongInfo(song: songs.elementAt(index)),
                            ),
                          );
                  }
                  return const CircularProgressIndicator();
                },
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

// TODO: Implement getSong, but haven't used yet
Future<void> getSong(songs) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Songs')
      .where('genres', arrayContains: 'Pop').get();
  for (var docSnapshot in querySnapshot.docs) {
      final String songUrl = await Storage.getSongUrl(docSnapshot['title']);
      final String imageUrl = await Storage.getSongAvatarUrl(docSnapshot['title']);
      // final Color shadow = await CustomColors.generatePaletteColor(imageUrl);
      songs.add(Song.fromJson(docSnapshot, imageUrl, songUrl));
    }
}
