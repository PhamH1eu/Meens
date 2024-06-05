// cloud_store/getSongs.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webtoon/model/song.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Song>> fetchSongs() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Songs').get();
      List<Song> songs = querySnapshot.docs.map((doc) {
        return Song.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return songs;
    } catch (e) {
      print('Error fetching songs: $e');
      return [];
    }
  }
}
