class ResultSong {
  final String name;
  final String images;
  final String artist;
  ResultSong({required this.name, required this.images, required this.artist});
  factory ResultSong.fromJson(dynamic json) {
    return ResultSong(
        name: json['title'] as String,
        images: json['images']['coverart'] as String,
        artist: json['subtitle'] as String);
  }
  static List<ResultSong> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return ResultSong.fromJson(data);
    }).toList();
  }
  @override
  String toString(){
    return 'ResultSong {name: $name, image: $images, artist: $artist}';
  }
}