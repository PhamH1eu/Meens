import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:webtoon/model/song.dart';

List<Song> playlist = [
  const Song(
    title: 'TTL - Listen 2',
    artist: 'T-ARA',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Ftara.jpg?alt=media&token=041b1471-4a1b-4c53-87f8-abc1cfb875e7',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2FTTL.mp3?alt=media&token=c3c438fa-af4c-4a15-8045-e35bc4afa966',
  ),
  const Song(
    title: 'Vo kich cua em',
    artist: 'Huong Ly',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fhophongan.jpg?alt=media&token=fef5c778-fa7c-49ee-a34c-c7e99963e48d',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fvokichcuaem.mp3?alt=media&token=b82a3baa-5f94-4f9e-81a0-f41e4c45d7c6',
  ),
  const Song(
    title: 'Atlantis',
    artist: 'Seafret',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fseafret.jpg?alt=media&token=3612b6f5-6b29-4121-b619-520cc93b86d9',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fatlantis.mp3?alt=media&token=40e223a9-64cf-44ec-ad73-f4bb78125323',
  ),
  const Song(
    title: 'Fly a letter the wind',
    artist: 'July',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fjuly.jpg?alt=media&token=f7362d5e-22fa-4ae9-bc7d-60fad9131cea',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fflyalettertothewind.mp3?alt=media&token=029d1a32-0a1b-4acd-a5de-52edd301541f',
  ),
  const Song(
    title: 'GODS',
    artist: 'New Jeans',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fnewjeans.jpg?alt=media&token=d57894c6-cbf0-4f2f-97cd-bbd43bafdd19',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fgods.mp3?alt=media&token=9266df98-a655-42c9-b751-c24ef8cb9b0b',
  ),
  const Song(
    title: 'Viva La Vida',
    artist: 'Coldplay',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fcoldplay.jpg?alt=media&token=4c15b070-dac9-4532-b340-fee903c3e821',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fvivalavida.mp3?alt=media&token=4b30c354-4086-4a67-9735-3b99ae7c9293',
  ),
  const Song(
    title: 'Your lie in april',
    artist: 'Hikaru Nara',
    imageUrl: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/artist%2Fhikarunara.jpg?alt=media&token=59cad8b6-2de0-492b-b351-3db33eb7b5f6',
    songPath: 'https://firebasestorage.googleapis.com/v0/b/webtoon-b9373.appspot.com/o/song%2Fyourlieinapril.mp3?alt=media&token=8bc5b7b6-8366-4d97-9f77-3ed341088dfb',
  ),
];

final _playlist = ConcatenatingAudioSource(
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

  //Haven't used those functions yet
  //
  //
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
