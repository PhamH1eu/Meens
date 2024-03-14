import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/song_provider.dart';
import 'widgets/control_button.dart';
import 'widgets/progress_bar.dart';

class PlayingScreen extends ConsumerStatefulWidget {
  const PlayingScreen({super.key});

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends ConsumerState<PlayingScreen> {


  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(audioHandlerProvider);
    return Scaffold(
      body: Column(
        children: <Widget>[
          StreamBuilder<PositionData>(
            stream: PositionData.positionDataStream(audioPlayer),
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              return ProgressBar(
                barHeight: 5,
                baseBarColor: Colors.black,
                bufferedBarColor: Theme.of(context).secondaryHeaderColor,
                progressBarColor: Theme.of(context).primaryColor,
                thumbColor: Theme.of(context).primaryColor,
                timeLabelTextStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12.0,
                ),
                timeLabelLocation: TimeLabelLocation.sides,
                progress: positionData?.position ?? Duration.zero,
                buffered: positionData?.bufferedPosition ?? Duration.zero,
                total: positionData?.duration ?? Duration.zero,
                onSeek: audioPlayer.seek,
              );
            },
          ),
          Control(audioPlayer: audioPlayer, size: 64.0,),
        ],
      ),
    );
  }
}
