class ResultSong {
  final String name;
  final String images;
  final String artist;
  final String demo;
  String? appleMusic = "";
  ResultSong(
      {required this.name,
      required this.images,
      required this.artist,
      required this.demo,
      this.appleMusic});
  factory ResultSong.fromJson(dynamic json) {
    print(json['myshazam']['apple']['actions'][0]);
    String apple = json['myshazam']['apple']['actions'][0]['uri'];
    return ResultSong(
        name: json['title'] as String,
        images: json['images']['coverart'] as String,
        artist: json['subtitle'] as String,
        demo: json['hub']['actions'][1]['uri'] as String,
        appleMusic: apple);
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
