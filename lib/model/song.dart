import 'package:flutter/material.dart';

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
