import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'song_recognized.dart';

class SongApi {
  static Future<List<ResultSong>> getRecipe(File file) async {
    var uri = Uri.https(
        'shazam-song-recognition-api.p.rapidapi.com', '/recognize/file');
    const apikey = String.fromEnvironment('API_KEY', defaultValue: '');
    final response = await http.post(
      uri,
      headers: {
        "content-type": "application/octet-stream",
        "x-rapidapi-key": apikey,
        "x-rapidapi-host": "shazam-song-recognition-api.p.rapidapi.com",
      },
      body: file.readAsBytesSync(),
    );
    //added this to json crack (need to show full msg);
    Map data = jsonDecode(response.body);
    List temp = [];
    temp.add(data['track']);
    return ResultSong.recipesFromSnapshot(temp);
  }
}
