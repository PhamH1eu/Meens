import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/miniplayer/widgets/progress_bar.dart';

import '../riverpod/song_provider.dart';
import 'widgets/control_button.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioHandlers = ref.watch(audioHandlerProvider);
    return GestureDetector(
      child: Align(
        alignment: const AlignmentDirectional(0, 1),
        child: SizedBox(
          height: 80,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: <Widget>[
                      Image.asset('assets/artwork.jpg',
                          width: 70, height: 70, fit: BoxFit.cover),
                      Wrap(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  ref.watch(audioHandlerProvider.notifier).currentSong.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 18),
                                ),
                                Text(
                                  ref.watch(audioHandlerProvider.notifier).currentSong.artist,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Control(
                        size: 30.0,
                        carouselController: CarouselController(),
                      )
                    ],
                  ),
                ),
              ),
              StreamBuilder<PositionData>(
                  stream: PositionData.positionDataStream(audioHandlers.audioPlayer),
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;

                    return ProgressBar(
                      barHeight: 5,
                      baseBarColor: const Color.fromRGBO(202, 202, 202, 1),
                      bufferedBarColor: Theme.of(context).hintColor,
                      progressBarColor: Theme.of(context).primaryColor,
                      thumbColor: Theme.of(context).primaryColor,
                      timeLabelTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 0,
                      ),
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: audioHandlers.audioPlayer.seek,
                    );
                  }),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed('/play'),
    );
  }
}
