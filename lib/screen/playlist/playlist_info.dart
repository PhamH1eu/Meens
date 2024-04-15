import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../riverpod/song_provider.dart';
import '../miniplayer/mini_player.dart';

class PlaylistInfo extends StatelessWidget {
  const PlaylistInfo({super.key});

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Playlist Info',
                    style: TextStyle(
                        fontWeight: CustomColors.extraBold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 30),
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
                          onPressed: () {}),
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
                            onTap: () {},
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
                    itemCount: 5,
                    itemExtent: 90,
                    itemBuilder: (context, index) {
                      return ListTile(
                        visualDensity: const VisualDensity(vertical: 3),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://via.placeholder.com/150',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          'Playlist $index',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17),
                        ),
                        subtitle: Text('$index Tracks',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15)),
                      );
                    },
                  ),
                ),
              ],
            ),
            const MiniPlayer(),
          ]),
        );
      },
    );
  }
}
