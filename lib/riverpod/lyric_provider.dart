import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:webtoon/riverpod/song_provider.dart';

String formatLyrics(List<Map<String, dynamic>> lyrics) {
  StringBuffer formattedString = StringBuffer();

  for (var lyric in lyrics) {
    int minutes = lyric['time']['minutes'];
    int seconds = lyric['time']['seconds'];
    int hundredths = lyric['time']['hundredths'];

    String formattedTime =
        '[${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${hundredths.toString().padLeft(2, '0')}]';
    String text = lyric['text'];

    formattedString.writeln('$formattedTime$text');
  }

  return formattedString.toString();
}

//create a Future provider for the lyrics api
final lyricProvider = FutureProvider.autoDispose<String>((ref) async {
  final audio = ref.watch(audioHandlerProvider);
  var uri = Uri.https("musixmatch-lyrics-songs.p.rapidapi.com", "/songs/lyrics",
      {'t': audio.currentSong.title, 'a': audio.currentSong.artist, 'type': 'json'});
  const apikey = String.fromEnvironment('API_KEY', defaultValue: '');
  final response = await http.get(uri, headers: {
    'x-rapidapi-key': apikey,
    'x-rapidapi-host': 'musixmatch-lyrics-songs.p.rapidapi.com',
    'Content-Type': 'application/json'
  });
  if (response.statusCode == 200) {
    List<Map<String, dynamic>> responseBody =
        List<Map<String, dynamic>>.from(json.decode(response.body));
    String res = formatLyrics(responseBody);
    ref.cacheFor(const Duration(minutes: 10));
    return (res);
  } else {
    ref.cacheFor(const Duration(minutes: 10));
    throw Exception('Failed to load lyric');
  }
});

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}
