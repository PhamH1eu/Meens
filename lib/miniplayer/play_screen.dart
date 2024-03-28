import 'dart:developer';

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

  CarouselController carouselController = CarouselController();

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
    final audioHandlers = ref.watch(audioHandlerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Now Playing',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
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
              initialPage: audioHandlers.audioPlayer.currentIndex ?? 0,
              onPageChanged: (index, reason) {
                reason = CarouselPageChangedReason.manual;
                audioHandlers.changeTo(index);
                log("this swipe index: $index");
              },
            ),
            carouselController: carouselController,
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
          Stack(children: <Widget>[
            Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      audioHandlers.currentSong.title,
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    Text(
                      audioHandlers.currentSong.artist,
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ]),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite_outline,
                      size: 30,
                      color: isFavorite
                          ? Colors.red
                          : Theme.of(context).secondaryHeaderColor,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: volumeLevel > 0.5
                      ? const Icon(Icons.volume_up)
                      : const Icon(Icons.volume_down),
                  color: const Color.fromRGBO(137, 150, 184, 1),
                  iconSize: 30,
                  onPressed: () {
                    setState(() {
                      showVolumeControl = !showVolumeControl;
                    });
                  },
                ),
                if (showVolumeControl)
                  Slider(
                    value: volumeLevel,
                    activeColor: Theme.of(context).secondaryHeaderColor,
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
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.repeat,
                    color: isRepeat
                        ? const Color.fromARGB(255, 124, 200, 10)
                        : const Color.fromRGBO(137, 150, 184, 1),
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
                    size: 30,
                    color: isShuffle
                        ? const Color.fromARGB(255, 124, 200, 10)
                        : const Color.fromRGBO(137, 150, 184, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      isShuffle = !isShuffle;
                      isRepeat = false;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<PositionData>(
              stream:
                  PositionData.positionDataStream(audioHandlers.audioPlayer),
              builder: (context, snapshot) {
                final positionData = snapshot.data;
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
          Control(size: 60, carouselController: carouselController),
        ],
      ),
    );
  }
}
