import 'package:flutter/material.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../model/song.dart';

class SongOfArtist extends StatefulWidget {
  const SongOfArtist({super.key, required this.song});

  final Song song;

  @override
  State<SongOfArtist> createState() => _SongOfArtistState();
}

class _SongOfArtistState extends State<SongOfArtist> {
  Color glowColor = Colors.black;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          // Ảnh
          Image.asset(
            widget.song.artWork,
            width: 40,
            height: 40,
          ),
          // Văn bản
           Padding(
              padding: const EdgeInsets.only(left: 8.0,bottom: 5),
              child: Text(
                widget.song.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
          // Nút tùy chọn
          IconButton(
            onPressed: () {
              // Hành động khi nút được nhấn
            },
            icon: const Icon(Icons.more_vert),

          ),
        ],
      ),
    );
  }
}
