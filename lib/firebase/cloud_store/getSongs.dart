// cloud_store/getSongs.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webtoon/model/song.dart';
import 'package:webtoon/firebase/cloud_store/store.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Song>> fetchSongs() async {
    try {
      // Fetch all songs
      final List<Song> songs = [];
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection('Songs').get();

      for (var docSnapshot in querySnapshot.docs) {
        final String title = docSnapshot['title'];
        final String songUrl = await Storage.getSongUrl(title);
        final String imageUrl = await Storage.getSongAvatarUrl(title);

        songs.add(Song.fromJson(docSnapshot.data(), imageUrl, songUrl));
      }

      return songs;
    } catch (e) {
      print('Error fetching songs: $e');
      return [];
    }
  }
}
