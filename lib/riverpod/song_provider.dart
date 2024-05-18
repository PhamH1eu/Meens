import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webtoon/model/song.dart';

ConcatenatingAudioSource getPlaylist(List<Song> playlist) {
  return ConcatenatingAudioSource(
    useLazyPreparation: true,
    children: playlist
        .map((song) => AudioSource.uri(Uri.parse(song.songPath!),
            tag: MediaItem(
              id: song.songPath!,
              artist: song.artist,
              title: song.title,
              // artUri: Uri.parse(song.imageUrl),
            )))
        .toList(),
  );
}

//set audio source khi user login

class AudioHandlers extends ChangeNotifier {
  //data for testing purpose, will refactor later
  final AudioPlayer audioPlayer = AudioPlayer();
  final List<Song> playlist = [];
  bool isPlaying = false;
  bool isCountdown = false;

  AudioHandlers() {
    playlist.clear();
    audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> setSong(Song song) async {
    isPlaying = true;
    playlist.clear();
    playlist.add(song);
    audioPlayer.setAudioSource(getPlaylist(playlist));
    if (!audioPlayer.playing) {
      audioPlayer.play();
    }
    notifyListeners();
  }

  Future<void> setPlaylist(List<Song> playlist) async {
    isPlaying = true;
    this.playlist.clear();
    this.playlist.addAll(playlist);
    audioPlayer.setAudioSource(getPlaylist(playlist));
    audioPlayer.play();
    notifyListeners();
  }

  Future setTimeout(Duration duration) {
    isCountdown = true;
    notifyListeners();
    return Future.delayed(duration, () {
      audioPlayer.pause();
      isPlaying = false;
      isCountdown = false;
      notifyListeners();
    });
  }
  
  bool get countdown {
    return isCountdown;
  }

  Song get currentSong {
    return playlist[audioPlayer.currentIndex ?? 0];
  }

  List<String> get imgList {
    return playlist.map((e) => e.imageUrl).toList();
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
    notifyListeners();
  }

  void clear() {
    audioPlayer.pause();
    isPlaying = false;
    audioPlayer.setLoopMode(LoopMode.all);
  }

  bool get showMini {
    return isPlaying;
  }

  LoopMode get loopMode {
    return audioPlayer.loopMode;
  }

  bool get isRepeat {
    return audioPlayer.loopMode != LoopMode.off;
  }

  bool get shuffleMode {
    return audioPlayer.shuffleModeEnabled;
  }

  void setShuffleMode() {
    audioPlayer.setLoopMode(LoopMode.off);
    audioPlayer.setShuffleModeEnabled(!audioPlayer.shuffleModeEnabled);
    notifyListeners();
  }

  void setLoopMode() {
    audioPlayer.setShuffleModeEnabled(false);
    switch (audioPlayer.loopMode) {
      case LoopMode.off:
        audioPlayer.setLoopMode(LoopMode.all);
        break;
      case LoopMode.all:
        audioPlayer.setLoopMode(LoopMode.one);
        break;
      case LoopMode.one:
        audioPlayer.setLoopMode(LoopMode.off);
        break;
    }
    notifyListeners();
  }

  void setVolume(double volume) {
    audioPlayer.setVolume(volume);
  }

  void replay() {
    audioPlayer.setAudioSource(getPlaylist(playlist));
    audioPlayer.play();
  }
}

final audioHandlerProvider = ChangeNotifierProvider<AudioHandlers>((ref) {
  return AudioHandlers();
});
