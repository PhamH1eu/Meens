import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/riverpod/firebase_provider.dart';

import '../../model/song.dart';
import '../../utilities/fonts.dart';
import 'widgets/song_info.dart';

Song song = Song(
    title: "Viva La Vida",
    artist: "Coldplay",
    imageUrl:
        'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fcoldplay.jpg?alt=media&token=4c15b070-dac9-4532-b340-fee903c3e821',
    songPath:
        'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fvivalavida.mp3?alt=media&token=4b30c354-4086-4a67-9735-3b99ae7c9293');

class HomeUI extends ConsumerWidget {

  const HomeUI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommend = ref.watch(recommendedSongsProvider);
    final likedsong = ref.watch(likedSongsProvider);
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
                child: recommend.when(
                  data: (songs) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 30);
                      },
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          SongInfo(song: songs[index]),
                    );
                  },
                  loading: () => Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )),
                  error: (error, stack) => Text('Error: $error'),
                )),
            const SizedBox(height: 20),
            Text(
              'Maybe you like it :3',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontFamily: 'Gilroy'),
            ),
            const SizedBox(height: 15),
            SizedBox(
                height: 240,
                child: likedsong.when(
                  data: (songs) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(width: 30);
                      },
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          SongInfo(song: songs[index]),
                    );
                  },
                  loading: () => Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )),
                  error: (error, stack) => Text('Error: $error'),
                )),
            // Đổi chỗ này thành artist
            // SizedBox(
            //   height: 240,
            //   child: ListView.separated(
            //     separatorBuilder: (BuildContext context, int index) {
            //       return const SizedBox(width: 30);
            //     },
            //     itemCount: 4,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (context, index) =>
            //         const PlaylistInfo(playlist: playlist),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

