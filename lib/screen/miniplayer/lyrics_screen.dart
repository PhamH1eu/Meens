import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/screen/miniplayer/widgets/control_button.dart';
import 'package:webtoon/screen/miniplayer/widgets/lyric_loader.dart';
import '../../model/song.dart';
import '../../riverpod/position_provider.dart';
import '../../riverpod/song_provider.dart';
import 'widgets/progress_bar.dart';

class LyricScreen extends ConsumerStatefulWidget {
  const LyricScreen({super.key});

  @override
  LyricScreenState createState() => LyricScreenState();
}

// Define a state class for the LyricScreen widget
class LyricScreenState extends ConsumerState<LyricScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final audioHandlers = ref.watch(audioHandlerProvider);
    Song currentSong = audioHandlers.currentSong;
    final positionData = ref.watch(positionDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lyrics',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_sharp),
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10, left: 10),
            visualDensity: const VisualDensity(vertical: 3),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                currentSong.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              currentSong.title,
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 17),
            ),
            subtitle: Text(currentSong.artist,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15)),
          ),
          const LyricLoader(),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<PositionData>(
              stream: positionData,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                if (positionData == null ||
                    audioHandlers.audioPlayer.duration == null) {
                } else {
                  if (positionData.position >
                      audioHandlers.audioPlayer.duration! -
                          const Duration(milliseconds: 500)) {
                    if (audioHandlers.audioPlayer.hasNext) {
                      audioHandlers.next();
                    }
                  }
                }
                return ProgressBar(
                  barHeight: 5,
                  baseBarColor: Theme.of(context).secondaryHeaderColor,
                  bufferedBarColor: Theme.of(context).hintColor,
                  progressBarColor: Theme.of(context).primaryColor,
                  thumbColor: Theme.of(context).primaryColor,
                  timeLabelTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Gilroy',
                    fontSize: 16.0,
                  ),
                  timeLabelLocation: TimeLabelLocation.above,
                  timeLabelPadding: 15,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: audioHandlers.audioPlayer.seek,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Control(size: 59, carouselController: CarouselController()),
          ),
        ],
      ),
    );
  }
}
