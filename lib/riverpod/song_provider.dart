import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webtoon/model/song.dart';

List<Song> playlist = [
  const Song(
    title: 'TTL - Listen 2',
    artist: 'T-ARA',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/TTL.mp3',
  ),
  const Song(
    title: 'Vo kich cua em',
    artist: 'Huong Ly',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/vokichcuaem.mp3',
  ),
  const Song(
    title: 'Stay',
    artist: 'Kid',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/Stay.mp3',
  ),
  const Song(
    title: 'Sold Out',
    artist: 'Malenia',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/SOLDOUT.mp3',
  ),
  const Song(
    title: 'HONGKONG1',
    artist: 'Miquella',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/HONGKONG1.mp3',
  ),
  const Song(
    title: 'Anh Dau Ngo',
    artist: 'Marika',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/anhdaungo.mp3',
  ),
  const Song(
    title: 'Mascara',
    artist: 'Godwyn',
    imageUrl:
        'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    songPath: 'assets/audios/Mascara Lung Linh.mp3',
  ),
];

final _playlist = ConcatenatingAudioSource(
  useLazyPreparation: true,
  children: playlist
      .map((song) => AudioSource.asset(song.songPath!,
          tag: MediaItem(
            id: song.songPath!,
            artist: song.artist,
            title: song.title,
            // artUri: Uri.parse(song.imageUrl),
          )))
      .toList(),
);

class AudioHandlers extends ChangeNotifier {
  //data for testing purpose, will refactor later
  final AudioPlayer audioPlayer = AudioPlayer();

  AudioHandlers() {
    audioPlayer.setAudioSource(_playlist);
    audioPlayer.setLoopMode(LoopMode.all);
  }

  Song get currentSong {
    return playlist[audioPlayer.currentIndex ?? 0];
  }

  Future<void> next() async {
    if (audioPlayer.hasNext) {
      await audioPlayer.seekToNext();
    }
    notifyListeners();
  }

  Future<void> back() async {
    if (audioPlayer.hasPrevious) {
      await audioPlayer.seekToPrevious();
    }
    notifyListeners();
  }

  Future<void> changeTo(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    log("changeTo index: ${audioPlayer.currentIndex}");
    notifyListeners();
  }

  //Haven't used those functions yet
  bool setShuffleMode() {
    audioPlayer.setShuffleModeEnabled(!audioPlayer.shuffleModeEnabled);
    notifyListeners();
    return audioPlayer.shuffleModeEnabled;
  }

  bool setLoopMode() {
    //Todo: Add LoopMode.one
    audioPlayer.setLoopMode(audioPlayer.loopMode == LoopMode.all
        ? LoopMode.off
        : LoopMode.all);
    notifyListeners();
    return audioPlayer.loopMode == LoopMode.all;
  }

  void setVolume() {
    audioPlayer.setVolume(audioPlayer.volume == 1.0 ? 0.0 : 1.0);
    notifyListeners();
  }
}

final audioHandlerProvider = ChangeNotifierProvider<AudioHandlers>((ref) {
  return AudioHandlers();
});
