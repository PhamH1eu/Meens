// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/profile/artist/songofartist/songofartist.dart';


import 'package:webtoon/utilities/fonts.dart';

import '../../home/homeui.dart';
import '../../riverpod/tab.dart';

class ArtistProfile extends StatelessWidget {
  const ArtistProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            backgroundColor: Colors.black87,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  ref.invalidate(countProvider);
                },
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/genres/header.jpg'), // Replace with your actual image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 0, left: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Son Tung MTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Hành động khi nút được nhấn
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(
                              color: Colors
                                  .white), // Thêm border color là màu trắng
                        ),
                        child: const Text(
                          'Follow',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      RawMaterialButton(
                        onPressed: () {
                          // Hành động khi nút được nhấn
                        },
                        elevation: 0.0,
                        fillColor: Colors.green,
                        shape: const CircleBorder(),
                        constraints: const BoxConstraints.tightFor(
                          width: 40.0,
                          height: 40.0,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'All song',
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Gilroy'),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: 9,
                      itemBuilder: (context, index) =>
                          const SongOfArtist(song: song)),
                ),
              ],
            ));
      },
    );
  }
}
