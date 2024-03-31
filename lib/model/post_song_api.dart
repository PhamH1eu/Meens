import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'song_recognized.dart';

class SongApi {
  static Future<List<ResultSong>> getRecipe(File file) async {
    var uri = Uri.https(
        'shazam-song-recognition-api.p.rapidapi.com', '/recognize/file');
    final response = await http.post(
      uri,
      headers: {
        "content-type": "application/octet-stream",
        "x-rapidapi-key": "Add your own api key here",
        "x-rapidapi-host": "shazam-song-recognition-api.p.rapidapi.com",
      },
      // body:  file.readAsBytes(),
      body: file.readAsBytesSync(),
    );
    Map data = jsonDecode(response.body);
    List temp = [];
    temp.add(data['track']);
    return ResultSong.recipesFromSnapshot(temp);
  }
}
