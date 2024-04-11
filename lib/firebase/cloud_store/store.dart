import 'package:diacritic/diacritic.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static final _storage = FirebaseStorage.instance;

  static Future<String> getArtistUrl(String name) {
    final storageRef = _storage.ref();
    final artistRef = storageRef.child('artist/$name.jpg');
    final artistUrl = artistRef.getDownloadURL();
    return artistUrl;
  }

  static Future<String> getSongUrl(String name) {
    final nameFile = removeDiacritics(name.toLowerCase().replaceAll(' ', ''));
    final storageRef = _storage.ref();
    final songRef = storageRef.child('song/$nameFile.mp3');
    final songUrl = songRef.getDownloadURL();
    return songUrl;
  }

  static Future<String> getSongAvatarUrl(String name) {
    final nameFile = removeDiacritics(name.toLowerCase().replaceAll(' ', ''));
    final storageRef = _storage.ref();
    final songAvatarRef = storageRef.child('song_avatar/${nameFile}_avatar.jpg');
    final songAvatarUrl = songAvatarRef.getDownloadURL();
    return songAvatarUrl;
  }

  void uploadMetadata(String name, String artist, ref) async {
    final newMeta =
        SettableMetadata(customMetadata: {'title': name, 'artist': artist});
    await ref.updateMetadata(newMeta);
  }
}
