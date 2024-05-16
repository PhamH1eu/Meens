import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webtoon/model/song_recognized.dart';
import 'package:webtoon/riverpod/song_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/song.dart';

class ShazamResult extends ConsumerWidget {
  const ShazamResult({super.key, required this.resultSong});

  final ResultSong resultSong;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioHandler = ref.watch(audioHandlerProvider);
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
              child: PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    onTap: () {
                      final Uri url = Uri.parse(resultSong.appleMusic!);
                      launchUrl(url);
                    },
                    child: ListTile(
                        leading: Icon(
                          Icons.ios_share_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          'Open in Apple Music',
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
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(resultSong.images),
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
              alignment: const Alignment(-0.9, 0.75),
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
                      child: Text(
                        resultSong.name,
                        style: const TextStyle(
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
                      child: Text(
                        resultSong.artist,
                        style: const TextStyle(
                            color: Color.fromRGBO(234, 240, 255, 1),
                            fontSize: 20),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (audioHandler.isPlaying) {
                        audioHandler.audioPlayer.pause();
                      }
                      audioHandler.setSong(Song(
                        title: resultSong.name,
                        artist: resultSong.artist,
                        imageUrl: resultSong.images,
                        songPath: resultSong.demo,
                      ));
                    },
                    icon: const Icon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
