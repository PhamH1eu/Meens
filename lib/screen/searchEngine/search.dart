// search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/model/song.dart';
import 'package:webtoon/firebase/cloud_store/getSongs.dart';
import 'package:webtoon/riverpod/song_provider.dart';

final songProvider = FutureProvider<List<Song>>((ref) async {
  final firestoreService = FirestoreService();
  return await firestoreService.fetchSongs();
});

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String searchText = "";
  List<Song> searchResult = [];

  void performSearch(String searchText, List<Song> songs) {
    searchResult.clear();
    if (searchText.isNotEmpty) {
      for (var song in songs) {
        if (song.title.toLowerCase().contains(searchText.toLowerCase())) {
          searchResult.add(song);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final songsAsyncValue = ref.watch(songProvider);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for songs...',
              hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
            ),
            style: TextStyle(color: Theme.of(context).primaryColor),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
              if (songsAsyncValue is AsyncData<List<Song>>) {
                performSearch(value, songsAsyncValue.value);
              }
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 19, 18, 18),
        elevation: 0,
      ),
      body: songsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (songs) {
          return searchResult.isNotEmpty
              ? ListView.builder(
                  itemCount: searchResult.length,
                  itemBuilder: (context, index) {
                    final song = searchResult[index];
                    return GestureDetector(
                      onTap: () {
                        // Gọi hàm setSong để phát bài hát được nhấn vào
                        ref.read(audioHandlerProvider.notifier).setSong(song);
                        // Điều hướng đến màn hình phát nhạc
                        Navigator.of(context).pushNamed('/play');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(song.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  song.artist,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text(
                    'No songs found',
                    style: TextStyle(color: Colors.black54, fontSize: 18),
                  ),
                );
        },
      ),
    );
  }
}
