import "package:flutter/material.dart";
import "package:webtoon/riverpod/song.dart";

List<Song> songs = [
  Song(
      id: "1",
      title: "Album",
      artist: "Artist",
      audioUrl: "assets/audios/TTL.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "2",
      title: "title",
      artist: "Artist2",
      audioUrl: "assets/audios/vokichcuaem.mp3",
      imgUrl: "assets/artwork.jpg"),
  Song(
      id: "3",
      title: "title3",
      artist: "Artist3",
      audioUrl: "assets/audios/anhdaungo.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "4",
      title: "title4",
      artist: "Artist4",
      audioUrl: "assets/audios/Stay.mp3",
      imgUrl: "assets/icon.png"),
  Song(
      id: "5",
      title: "title5",
      artist: "Artist5",
      audioUrl: "assets/audios/HONGKONG1.mp3",
      imgUrl: "assets/icon.png"),
];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = "";
  List<Song> searchResult = [];

  void performSearch(String searchText) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 122, 120, 120),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search for songs...',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10),
            ),
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              setState(() {
                searchText = value;
              });
              performSearch(value);
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 19, 18, 18),
        elevation: 0,
      ),
      body: searchResult.isNotEmpty
          ? ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final song = searchResult[index];
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: AssetImage(song.imgUrl),
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            song.artist,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Container(
                      height: 60,
                      color: const Color.fromARGB(255, 217, 18, 18), // Màu nền trắng cho khoảng cách giữa các kết quả
                    ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: searchText.isEmpty
                  ? const Text('Start typing to search...')
                  : Text('No results found for "$searchText"'),
            ),
    );
  }
}

// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search'),
//       ),
//       body: Center(
//         child: Text('Search Screen'),
//       ),
//     );
//   }
// }