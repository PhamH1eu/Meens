import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/likedsong/widgets/like_song.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../home/homeui.dart';
import '../riverpod/tab.dart';

List<String> images = [
  "https://static.cafedev.vn/tutorial/flutter/images/flutter-logo.png",
  "https://static.cafedev.vn/tutorial/flutter/images/flutter-logo.png",
  "https://static.cafedev.vn/tutorial/flutter/images/flutter-logo.png",
  "https://static.cafedev.vn/tutorial/flutter/images/flutter-logo.png"
];

class LikedSong extends StatelessWidget {
  const LikedSong({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.invalidate(countProvider);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                  // Xử lý khi nút "filter" được nhấn
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Text(
                  'Liked Songs',
                  style: TextStyle(
                      fontWeight: CustomColors.extraBold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontFamily: 'Gilroy'),
                ),
                const SizedBox(height: 20),
                 Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.65),
                      ),
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index){
                        return const LikeSongInfo(song: song);
                      },
                    ),
                  ),


                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
