import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webtoon/model/song.dart';

List<Song> playlist = [
  const Song(
    title: 'TTL - Listen 2',
    artist: 'T-ARA',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/TTL.mp3',
  ),
  const Song(
    title: 'Vo kich cua em',
    artist: 'Huong Ly',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/vokichcuaem.mp3',
  ),
  const Song(
    title: 'Stay',
    artist: 'Kid',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/Stay.mp3',
  ),
  const Song(
    title: 'Sold Out',
    artist: 'Malenia',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/SOLDOUT.mp3',
  ),
  const Song(
    title: 'HONGKONG1',
    artist: 'Miquella',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/HONGKONG1.mp3',
  ),
  const Song(
    title: 'Anh Dau Ngo',
    artist: 'Marika',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/anhdaungo.mp3',
  ),
  const Song(
    title: 'Mascara',
    artist: 'Godwyn',
    artWork: 'https://assetsio.gnwcdn.com/elden-ring-ranni.jpg?width=1600&height=900&fit=crop&quality=100&format=png&enable=upscale&auto=webp',
    url: 'assets/audios/Mascara Lung Linh.mp3',
  ),
];

class AudioHandler extends Notifier<AudioPlayer> {
  //data for testing purpose, will refactor later
  final _playlist = ConcatenatingAudioSource(
    children: playlist
        .map((song) => AudioSource.asset(song.url,
            tag: MediaItem(
              id: song.url,
              artist: song.artist,
              title: song.title,
              artUri: Uri.parse(song.artWork),
            )))
        .toList(),
  );
  

  @override
  AudioPlayer build() {
    AudioPlayer audioPlayer = AudioPlayer();
    audioPlayer.setAudioSource(_playlist);
    audioPlayer.setLoopMode(LoopMode.all);
    return audioPlayer;
  }

  //unavailable methods???

  // void setSource(String url) {
  //   state.setAudioSource(AudioSource.uri(Uri.parse(url)));
  // }

  // void play() {
  //   state.play();
  // }

  // void pause() {
  //   state.pause();
  // }

  // void stop() {
  //   state.stop();
  // }

  // void seek(Duration position) {
  //   state.seek(position);
  // }

  // void seekToPrevious() {
  //   state.seekToPrevious();
  // }

  // void seekToNext() {
  //   state.seekToNext();
  // }

  // void seekToIndex(int index) {
  //   state.seek(Duration.zero, index: index);
  // }

  // void dispose() {
  //   state.dispose();
  // }

  // void setLoopMode(LoopMode loopMode) {
  //   state.setLoopMode(loopMode);
  // }

  // void setShuffleModeEnabled(bool enabled) {
  //   state.setShuffleModeEnabled(enabled);
  // }

  // void setAudioSource(AudioSource source) {
  //   state.setAudioSource(source);
  // }
}

final audioHandlerProvider = NotifierProvider<AudioHandler, AudioPlayer>(() {
  return AudioHandler();
});
