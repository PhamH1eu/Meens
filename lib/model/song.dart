import 'package:just_audio_background/just_audio_background.dart';

class Song {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final String? songUrl;
  final String? songPath;

  const Song({
    this.id = "",
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.songUrl,
    this.songPath,
  }) : assert(songUrl != null || songPath != null);

  factory Song.fromMediaItem(MediaItem mediaItem) {
    String? songPath, songUrl;

    if ((mediaItem.extras!['url'] as String).startsWith('asset:///')) {
      songPath = mediaItem.extras!['url'].toString().replaceFirst('asset:///', '');
    } else {
      songUrl = mediaItem.extras!['url'];
    }

    return Song(
      id: mediaItem.id,
      title: mediaItem.title,
      artist: mediaItem.artist ?? "",
      imageUrl: mediaItem.artUri?.toString() ?? "",
      songPath: songPath,
      songUrl: songUrl,
    );
  }

  MediaItem toMediaItem() {
    return MediaItem(
      id: id,
      album: "",
      title: title,
      artist: artist,
      artUri: Uri.parse(imageUrl),
      extras: <String, dynamic>{'url': songPath != null ? 'asset:///$songPath' : songUrl},
    );
  }
}
