import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

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
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('Downloaded Songs',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)))),
          backgroundColor: Color.fromARGB(255, 242, 242, 242), // Đặt màu nền cho AppBar
          foregroundColor: Color.fromARGB(255, 158, 158, 158)),
      body: songs.isNotEmpty
        ? ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return ListTile(
                leading: Image.asset("assets/artwork.jpg"),
                title: Text(song.title ?? 'Unknown'),
                subtitle: Text(song.artist ?? 'Unknown Artist'),
                onTap: () {
                  // Xử lý khi nhấn vào một bài hát
                },
              );
            },
          )
        : Center(
            child: Text('Không có bài hát nào được tìm thấy.'),
          ),
  );
  }
}
