import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../riverpod/song_provider.dart';
import 'widgets/control_button.dart';
import 'widgets/progress_bar.dart';

import 'package:carousel_slider/carousel_slider.dart';

class PlayingScreen extends ConsumerStatefulWidget {
  const PlayingScreen({super.key});

  @override
  PlayingScreenState createState() => PlayingScreenState();
}

class PlayingScreenState extends ConsumerState<PlayingScreen> {
  bool isFavorite = false;
  bool showVolumeControl = false;
  double volumeLevel = 0.5;

  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                audioHandlers.changeTo(index);
              },
            ),
            carouselController: carouselController,
            items: audioHandlers.imgList
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
          //te
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
                      : volumeLevel == 0
                          ? const Icon(Icons.volume_off)
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
                        audioHandlers.setVolume(value);
                      });
                    },
                  ),
                const Spacer(),
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
                    Icons.shuffle,
                    size: 30,
                    color: audioHandlers.shuffleMode
                        ? const Color.fromARGB(255, 124, 200, 10)
                        : const Color.fromRGBO(137, 150, 184, 1),
                  ),
                  onPressed: () {
                    audioHandlers.setShuffleMode();
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
                if (positionData == null ||
                    audioHandlers.audioPlayer.duration == null) {
                } else {
                  if (positionData.position >
                      audioHandlers.audioPlayer.duration! -
                          const Duration(milliseconds: 500)) {
                    carouselController
                        .animateToPage(audioHandlers.audioPlayer.nextIndex!);
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
          Control(size: 60, carouselController: carouselController),
        ],
      ),
    );
  }
}
