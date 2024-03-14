import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/miniplayer/widgets/progress_bar.dart';

import '../riverpod/song_provider.dart';
import 'widgets/control_button.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayer = ref.watch(audioHandlerProvider);

    return GestureDetector(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              StreamBuilder<PositionData>(
                  stream: PositionData.positionDataStream(audioPlayer),
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ProgressBar(
                        barHeight: 5,
                        baseBarColor: Colors.black,
                        bufferedBarColor:
                            Theme.of(context).secondaryHeaderColor,
                        progressBarColor: Theme.of(context).primaryColor,
                        thumbColor: Theme.of(context).primaryColor,
                        timeLabelTextStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.0,
                        ),
                        timeLabelLocation: TimeLabelLocation.sides,
                        progress: positionData?.position ?? Duration.zero,
                        buffered:
                            positionData?.bufferedPosition ?? Duration.zero,
                        total: positionData?.duration ?? Duration.zero,
                        onSeek: audioPlayer.seek,
                      ),
                    );
                  }),
              Row(
                children: <Widget>[
                  Image.asset('assets/artwork.jpg',
                      width: 60, height: 60, fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'The Weeknd',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                        ),
                        Text(
                          'Blinding Lights',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).secondaryHeaderColor,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Control(
                    audioPlayer: audioPlayer,
                    size: 20.0,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.of(context).pushNamed('/play'),
    );
  }
}
