import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final _storage = FirebaseStorage.instance;

  Future<String> getArtistUrl(String name) {
    final storageRef = _storage.ref();
    final artistRef = storageRef.child('artist/$name.jpg');
    final artistUrl = artistRef.getDownloadURL();
    return artistUrl;
  }

  Future<String> getSongUrl(String name) {
    final storageRef = _storage.ref();
    final songRef = storageRef.child('song/$name.mp3');
    final songUrl = songRef.getDownloadURL();
    return songUrl;
  }

  Future<String> getSongAvatarUrl(String name) {
    final storageRef = _storage.ref();
    final songAvatarRef = storageRef.child('song_avatar/$name.jpg');
    final songAvatarUrl = songAvatarRef.getDownloadURL();
    return songAvatarUrl;
  }

  void uploadMetadata(String name, String artist, ref) async {
    final newMeta =
        SettableMetadata(customMetadata: {'title': name, 'artist': artist});
    await ref.updateMetadata(newMeta);
  }
}
