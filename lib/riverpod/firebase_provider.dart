import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/firebase/cloud_store/store.dart';
import 'package:webtoon/model/song.dart';

final recommendedSongsProvider = FutureProvider.autoDispose((ref) async {
  List<String> genres = [];
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .get()
      .then((value) {
    if (value.data() != null) {
      genres = List.from(value.data()!['genres']);
    }
  });

  final List<Song> songs = [];
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;
  if (genres.isNotEmpty) {
    querySnapshot = await FirebaseFirestore.instance
        .collection('Songs')
        .where('genres', arrayContainsAny: genres)
        .limit(10)
        .get();
  } else {
    querySnapshot =
        await FirebaseFirestore.instance.collection('Songs').limit(10).get();
  }
  for (var docSnapshot in querySnapshot.docs) {
    final String songUrl = await Storage.getSongUrl(docSnapshot['title']);
    final String imageUrl =
        await Storage.getSongAvatarUrl(docSnapshot['title']);
    songs.add(Song.fromJson(docSnapshot, imageUrl, songUrl));
  }
  // Cache results; It will not be called again
  ref.cacheFor(const Duration(minutes: 10));
  return songs;
});

final artistSongsProvider = FutureProvider.autoDispose.family<List<Song>, String>((ref, artistName) async {

  final List<Song> artistSongs = [];
  final QuerySnapshot<Map<String, dynamic>> querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection('Songs')
        .where('artist', arrayContains: artistName)
        .limit(10)
        .get();

  for (var docSnapshot in querySnapshot.docs) {
    final String songUrl = await Storage.getSongUrl(docSnapshot['title']);
    final String imageUrl =
    await Storage.getSongAvatarUrl(docSnapshot['title']);
    artistSongs.add(Song.fromJson(docSnapshot, imageUrl, songUrl));
  }
  // Cache results; It will not be called again
  ref.cacheFor(const Duration(minutes: 10));
  return artistSongs;
});

final getImageProvider =
    FutureProvider.autoDispose.family<List<String>, String>((ref, id) async {
  final List<String> songs = [];
  final docSnapshot = await FirebaseFirestore.instance
      .collection(
          '/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/$id/Songs/')
      .get();
  for (var doc in docSnapshot.docs) {
    final String imageUrl = await Storage.getSongAvatarUrl(doc['title']);
    songs.add(imageUrl);
  }
  ref.cacheFor(const Duration(minutes: 10));
  return songs;
});

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// Keeps the provider alive for [duration].
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}
