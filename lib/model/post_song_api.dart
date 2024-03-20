import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'song_recognized.dart';

import 'dart:developer';

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class RecipeApi {
  static Future<List<ResultSong>> getRecipe() async {
    File audioFile = await getImageFileFromAssets('audios/TTL.mp3');

    var uri = Uri.https(
        'shazam-song-recognition-api.p.rapidapi.com', '/recognize/file');
    final response = await http.post(
      uri,
      headers: {
        "content-type": "application/octet-stream",
        "x-rapidapi-key": "5c62c82941msh30d4e5fb73bb29cp13da0djsn3f6ff0029bba",
        "x-rapidapi-host": "shazam-song-recognition-api.p.rapidapi.com",
      },
      body: await audioFile.readAsBytes(),
    );
    log(response.body);
    Map data = jsonDecode(response.body);
    List temp = [];
    temp.add(data['track']);
    return ResultSong.recipesFromSnapshot(temp);
  }
}
