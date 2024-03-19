import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioHandler extends Notifier<AudioPlayer> {
  //data for testing purpose, will refactor later
  final _playlist = ConcatenatingAudioSource(children: [
    AudioSource.asset('assets/audios/TTL.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/vokichcuaem.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/Stay.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/SOLDOUT.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/HONGKONG1.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/anhdaungo.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    AudioSource.asset('assets/audios/Mascara Lung Linh.mp3',
        tag: const MediaItem(
          id: '1',
          album: "Album",
          title: "Title",
          artist: "Artist",
          // artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
        )),
    // AudioSource.uri(Uri.parse('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'), tag: MediaItem(
    //   id: '1',
    //   album: "Album",
    //   title: "Title",
    //   artist: "Artist",
    //   artUri: Uri.parse("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"),
    // )),
  ]);

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
