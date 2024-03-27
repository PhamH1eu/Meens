import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:volume_controller/volume_controller.dart';
import '../riverpod/song_provider.dart';
import 'widgets/control_button.dart';
import 'widgets/progress_bar.dart';

import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://c.saavncdn.com/137/Whatever-It-Takes-The-Meaning--English-2018-20180607173109-500x500.jpg',
  'https://c.saavncdn.com/137/Whatever-It-Takes-The-Meaning--English-2018-20180607173109-500x500.jpg',
  'https://c.saavncdn.com/137/Whatever-It-Takes-The-Meaning--English-2018-20180607173109-500x500.jpg',
  'https://c.saavncdn.com/137/Whatever-It-Takes-The-Meaning--English-2018-20180607173109-500x500.jpg',
  'https://c.saavncdn.com/137/Whatever-It-Takes-The-Meaning--English-2018-20180607173109-500x500.jpg',
];

class PlayingScreen extends ConsumerStatefulWidget {
  const PlayingScreen({super.key});

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends ConsumerState<PlayingScreen> {
  bool isFavorite = false;
  bool isRepeat = false;
  bool isShuffle = false;
  bool showVolumeControl = false;
  double volumeLevel = 0.5;

  @override
  void initState() {
    super.initState();
    // Listen to system volume change
    // VolumeController().listener((volume) {
    //   setState(() => volumeLevel = volume);
    // });

    // VolumeController().getVolume().then((volume) => volumeLevel = volume);
  }

  @override
  void dispose() {
    // VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayer = ref.watch(audioHandlerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Now Playing'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.4,
              viewportFraction: 0.7,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enableInfiniteScroll: false,
            ),
            items: imgList
                .map((item) => Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.fill,
                              ),
                            ],
                          )),
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          Stack(children: <Widget>[
            const Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Song Title',
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(95, 0, 0, 0)),
                    ),
                    Text(
                      'Artist Name',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 62, 85, 149)),
                    ),
                  ]),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFavorite ? Colors.red : null,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: volumeLevel > 0.5
                    ? const Icon(Icons.volume_up)
                    : const Icon(Icons.volume_down),
                onPressed: () {
                  setState(() {
                    showVolumeControl = !showVolumeControl;
                  });
                },
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  Icons.repeat,
                  color:
                      isRepeat ? const Color.fromARGB(255, 124, 200, 10) : null,
                ),
                onPressed: () {
                  setState(() {
                    isRepeat = !isRepeat;
                    isShuffle = false;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.shuffle,
                  color: isShuffle
                      ? const Color.fromARGB(255, 124, 200, 10)
                      : null,
                ),
                onPressed: () {
                  setState(() {
                    isShuffle = !isShuffle;
                    isRepeat = false;
                  });
                },
              ),
              if (showVolumeControl)
                Slider(
                  value: volumeLevel,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (double value) {
                    setState(() {
                      volumeLevel = value;
                      // VolumeController().setVolume(volumeLevel);
                    });
                    value = volumeLevel;
                  },
                ),
            ],
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder<PositionData>(
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
                    fontSize: 15.0,
                  ),
                  timeLabelLocation: TimeLabelLocation.above,
                  progress: positionData?.position ?? Duration.zero,
                  buffered: positionData?.bufferedPosition ?? Duration.zero,
                  total: positionData?.duration ?? Duration.zero,
                  onSeek: audioPlayer.seek,
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Control(audioPlayer: audioPlayer, size: 60),
        ],
      ),
    );
  }
}
