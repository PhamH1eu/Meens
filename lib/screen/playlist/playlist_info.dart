import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webtoon/model/playlist.dart';
import 'package:webtoon/riverpod/firebase_provider.dart';
import 'package:webtoon/screen/playlist/widgets/thumbnails.dart';

import 'package:webtoon/utilities/fonts.dart';

import '../../riverpod/song_provider.dart';
import '../miniplayer/mini_player.dart';

class PlaylistInfo extends StatefulWidget {
  const PlaylistInfo({super.key, required this.playlist});

  final Playlist playlist;

  @override
  State<PlaylistInfo> createState() => _PlaylistInfoState();
}

class _PlaylistInfoState extends State<PlaylistInfo> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final audioHandlers = ref.watch(audioHandlerProvider);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Stack(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: PlaylistThumbnail(
                        imageUrls: widget.playlist.songs
                            .map((e) => e.imageUrl)
                            .toList(), 
                        size: 200),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                    child: Text(
                      widget.playlist.title,
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0 , left: 10.0),
                    child: Text(
                      "${widget.playlist.songs.length} tracks",
                      style: TextStyle(
                          fontWeight: CustomColors.regular,
                          color: Theme.of(context).primaryColor,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            switch (audioHandlers.loopMode) {
                              LoopMode.off => Icons.repeat,
                              LoopMode.all => Icons.repeat,
                              LoopMode.one => Icons.repeat_one,
                            },
                            color: audioHandlers.isRepeat
                                ? const Color.fromARGB(255, 124, 200, 10)
                                : const Color.fromRGBO(137, 150, 184, 1),
                          ),
                          iconSize: 30,
                          onPressed: () {
                            audioHandlers.setLoopMode();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.shuffle,
                            size: 30,
                            color: audioHandlers.shuffleMode
                                ? const Color.fromARGB(255, 124, 200, 10)
                                : const Color.fromRGBO(137, 150, 184, 1),
                          ),
                          onPressed: () {
                            audioHandlers.setShuffleMode();
                          },
                        ),
                        IconButton(
                            icon: const Icon(FontAwesomeIcons.circlePlay),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              ref
                                  .read(audioHandlerProvider.notifier)
                                  .setPlaylist(widget.playlist.songs);
                              Navigator.of(context).pushNamed('/play');
                            }),
                        const Spacer(),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              onTap: () {},
                              child: ListTile(
                                  leading: Icon(
                                    Icons.ios_share_sharp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text(
                                    'Share',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15),
                                  )),
                            ),
                            PopupMenuItem(
                              value: 2,
                              onTap: () {
                                deletePlaylist();
                                Navigator.of(context).pop();
                              },
                              child: ListTile(
                                  leading: Icon(
                                    Icons.playlist_remove_sharp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  title: Text(
                                    'Remove from library',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15),
                                  )),
                            ),
                          ],
                          icon: Icon(
                            Icons.more_horiz_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      key: UniqueKey(),
                      itemCount: widget.playlist.songs.length,
                      itemExtent: 90,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(audioHandlerProvider.notifier)
                                .setSong(widget.playlist.songs[index]);
                            Navigator.of(context).pushNamed('/play');
                          },
                          child: Slidable(
                            endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (BuildContext context) {
                                      deleteSongFromPlaylist(
                                          widget.playlist.songs[index].title);
                                          setState(() {
                                            widget.playlist.songs.removeAt(index);
                                          });
                                      ref.invalidate(getImageProvider(widget.playlist.title));
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete_forever_sharp,
                                    label: 'Delete',
                                  ),
                                ]),
                            child: ListTile(
                              visualDensity: const VisualDensity(vertical: 3),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  widget.playlist.songs[index].imageUrl,
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                widget.playlist.songs[index].title,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17),
                              ),
                              subtitle: Text(widget.playlist.songs[index].artist,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const MiniPlayer(),
          ]),
        );
      },
    );
  }

  void deletePlaylist() async {
    await FirebaseFirestore.instance
        .collection(
            "/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/${widget.playlist.title}/Songs/")
        .get()
        .then((value) {
      for (var doc in value.docs) {
        doc.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection(
            "/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/")
        .doc(widget.playlist.title)
        .delete();
  }

  void deleteSongFromPlaylist(String name) async {
    await FirebaseFirestore.instance
        .collection(
            "/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/${widget.playlist.title}/Songs/")
        .doc(name)
        .delete();
  }
}
