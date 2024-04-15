import 'package:webtoon/model/song.dart';

class Playlist {
  final String title;
  final List<Song> songs;

  const Playlist({
    required this.title,
    required this.songs,
  });
}