import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:webtoon/riverpod/song_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webtoon/model/song.dart';
// import 'package:webtoon/model/song.dart';

class Library extends ConsumerStatefulWidget {
  const Library({super.key});

  @override
  ConsumerState<Library> createState() => _LibraryState();
}

class _LibraryState extends ConsumerState<Library> {
  late List<SongModel> songs = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    // Yêu cầu quyền truy cập bộ nhớ
    if (await Permission.storage.request().isGranted) {
      _getAllMp3Files();
    } else {
      // Hiển thị thông báo yêu cầu quyền nếu không được cấp
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Quyền truy cập bộ nhớ bị từ chối.'),
        ),
      );
    }
  }

  Future<void> _getAllMp3Files() async {
    try {
      List<SongModel> songList = await _audioQuery.querySongs(
        sortType: SongSortType.TITLE, // Sắp xếp theo tiêu đề bài hát
        orderType: OrderType.ASC_OR_SMALLER, // Thứ tự tăng dần
        uriType: UriType.EXTERNAL, // Truy vấn từ bộ nhớ ngoài
      );
      setState(() {
        songs = songList;
      });
    } catch (e) {
      // Xử lý lỗi
      print("Lỗi khi truy vấn bài hát: $e");
    }
  }

  
  Song _songModelToSong(SongModel songModel) {
    List<String> parts = songModel.title.split(' - ');
    String title = parts[0].trim();
    String artist = parts.length > 1 ? parts[1].trim() : 'Unknown Artist';
    // songModel.artist = artist;
    return Song(
      title: title,
      artist: artist,
      imageUrl: '', // Bạn có thể thêm logic để lấy ảnh bìa nếu có
      songPath: songModel.data,
    );
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
                  leading: QueryArtworkWidget(
                    id: song.id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Image.asset("assets/artwork.jpg"),
                  ),
                  title: Text(song.title),
                  subtitle: Text(song.artist ?? 'Unknown Artist'),
                  onTap: () {
                    ref.read(audioHandlerProvider.notifier).setSong(_songModelToSong(song));
                    // Điều hướng đến màn hình phát nhạc
                    Navigator.of(context).pushNamed('/play');
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
