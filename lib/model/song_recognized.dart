import 'dart:developer';

class ResultSong {
  final String name;
  final String images;
  final String artist;
  final String demo;
  final String shazamUrl;
  final String appleMusic;
  ResultSong(
      {required this.name,
      required this.images,
      required this.artist,
      required this.demo,
      required this.shazamUrl,
      required this.appleMusic});
  factory ResultSong.fromJson(dynamic json) {
    log(json.toString());
    return ResultSong(
      name: json['title'] as String,
      images: json['images']['coverart'] as String,
      artist: json['subtitle'] as String,
      demo: json['hub']['actions'][1]['uri'] as String,
      shazamUrl: json['url'] as String,
      appleMusic: json['hub']['options'][0]['actions'][0]['uri'] as String,
    );
  }
  static List<ResultSong> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ResultSong.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'ResultSong {name: $name, image: $images, artist: $artist}';
  }
}
