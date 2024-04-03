import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../riverpod/song_provider.dart';

class Control extends ConsumerWidget {
  const Control(
      {super.key, required this.size, required this.carouselController});
  final double size;
  final CarouselController carouselController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioHandler = ref.watch(audioHandlerProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: const Icon(Icons.skip_previous_outlined),
          iconSize: size,
          onPressed: () {
            if (size == 60) {
              if (audioHandler.audioPlayer.currentIndex == 0) {
                carouselController
                    .jumpToPage(audioHandler.audioPlayer.sequence!.length - 1);
              } else {
                carouselController.previousPage();
              }
            }
            audioHandler.back();
          },
        ),
        StreamBuilder<PlayerState>(
          stream: audioHandler.audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return const CircularProgressIndicator();
            } else if (playing != true) {
              return IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.play_arrow_outlined),
                iconSize: size,
                onPressed: audioHandler.audioPlayer.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.pause_outlined),
                iconSize: size,
                onPressed: audioHandler.audioPlayer.pause,
              );
            } else {
              return IconButton(
                color: Theme.of(context).primaryColor,
                icon: const Icon(Icons.replay_outlined),
                iconSize: size,
                onPressed: () =>
                    audioHandler.audioPlayer.seek(Duration.zero, index: 0),
              );
            }
          },
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: const Icon(Icons.skip_next_outlined),
          iconSize: size,
          onPressed: () {
            if (size == 60) {
              if (audioHandler.audioPlayer.currentIndex ==
                  audioHandler.audioPlayer.sequence!.length - 1) {
                carouselController.jumpToPage(0);
              } else {
                carouselController.nextPage();
              }
            }
            audioHandler.next();
          },
        ),
      ],
    );
  }
}
