import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  late List<SongModel> songs = [];

  @override
  void initState() {
    super.initState();
    _getAllMp3Files();
  }

  Future<void> _getAllMp3Files() async {
    try {
      OnAudioQuery().querySongs().then((value) {
        setState(() {
          songs = value;
        });
      });
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text('Downloaded Songs',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
          backgroundColor: const Color.fromARGB(255, 242, 242, 242), // Đặt màu nền cho AppBar
          foregroundColor: const Color.fromARGB(255, 158, 158, 158)),
      body: songs.isNotEmpty
        ? ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return ListTile(
                leading: Image.asset("assets/artwork.jpg"),
                title: Text(song.title),
                subtitle: Text(song.artist ?? 'Unknown Artist'),
                onTap: () {
                  // Xử lý khi nhấn vào một bài hát
                },
              );
            },
          )
        : const Center(
            child: Text('Không có bài hát nào được tìm thấy.'),
          ),
  );
  }
}
