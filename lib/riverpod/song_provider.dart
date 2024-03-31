import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webtoon/home/homeui.dart';
import 'package:webtoon/riverpod/song.dart';

//Song Data
List<Song> songs = [
  Song(
      id: "1",
      title: "Album",
      artist: "Artist",
      audioUrl: "assets/audios/TTL.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "2",
      title: "title",
      artist: "Artist2",
      audioUrl: "assets/audios/vokichcuaem.mp3",
      imgUrl: "assets/artwork.jpg"),
  Song(
      id: "3",
      title: "title3",
      artist: "Artist3",
      audioUrl: "assets/audios/anhdaungo.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "4",
      title: "title4",
      artist: "Artist4",
      audioUrl: "assets/audios/Stay.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "5",
      title: "title5",
      artist: "Artist5",
      audioUrl: "assets/audios/HONGKONG1.mp3",
      imgUrl: "assets/icon.png"),
];

class AudioHandler extends Notifier<AudioPlayer> {
  List<AudioSource> playlist = songs.map((song) {
      return AudioSource.asset(
        song.audioUrl,
        tag: MediaItem(
          id: song.id,
          album: "Album",
          title: song.title,
          artist: song.artist,
        ),
      );
    }).toList();

  
  late final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: playlist);

  @override
  AudioPlayer build() {
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setAudioSource(_playlist);
    audioPlayer.setLoopMode(LoopMode.all);
    return audioPlayer;
  }

  void setSource(String url) {
    state.setAudioSource(AudioSource.uri(Uri.parse(url)));
  }

  void play() {
    state.play();
  }

  void pause() {
    state.pause();
  }

  void stop() {
    state.stop();
  }

  void seek(Duration position) {
    state.seek(position);
  }

  void seekToPrevious() {
    state.seekToPrevious();
  }

  void seekToNext() {
    state.seekToNext();
  }

  void dispose() {
    state.dispose();
  }

  void setLoopMode(LoopMode loopMode) {
    state.setLoopMode(loopMode);
  }

  void setShuffleModeEnabled(bool enabled) {
    state.setShuffleModeEnabled(enabled);
  }

  void setAudioSource(AudioSource source) {
    state.setAudioSource(source);
  }
}

final audioHandlerProvider = NotifierProvider<AudioHandler, AudioPlayer>(() {
  return AudioHandler();
});


// final progressProvider = StreamProvider<PositionData>((ref) =>
//     Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
//       audioPlayer.positionStream,
//       audioPlayer.bufferedPositionStream,
//       audioPlayer.durationStream,
//       (position, bufferedPosition, duration) =>
//           PositionData(position, bufferedPosition, duration ?? Duration.zero),
//     ));
