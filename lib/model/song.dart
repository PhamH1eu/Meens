import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class Song {
  final String title;
  final String artist;
  final String imageUrl;
  final String? songPath;
  late Color? glowColor;

  Song({
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.songPath,
    this.glowColor,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'artist': [artist].toList(),
      };

  factory Song.fromJson(dynamic json, String image, String song) {
    return Song(
        title: json['title'] as String,
        artist: json['artist'][0] as String,
        imageUrl: image,
        songPath: song,);
  }

  @override
  String toString() {
    return 'Song {title: $title, artist: $artist, imageUrl: $imageUrl, songPath: $songPath}';
  }
}

Future<String?> downloadAndSaveSong(Song song) async {
  try {
    // Tải file nhạc từ URL
    var file = await DefaultCacheManager().getSingleFile(song.songPath!);

    // Lấy đường dẫn thư mục lưu trữ trên thiết bị
    var dir = await getApplicationDocumentsDirectory();

    // Tạo đường dẫn cho file nhạc
    String newPath = '${dir.path}/${song.title}.mp3';

    // Lưu file vào đường dẫn mới
    await file.copy(newPath);
    print("Saved song to: $newPath");
    // Trả về đường dẫn của file đã lưu
    return newPath;
  } catch (e) {
    print("Error saving song: $e");
    return null;
  }
}
