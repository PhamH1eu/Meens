// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:webtoon/screen/playlist/widgets/add_playlist.dart';
import 'package:webtoon/screen/playlist/widgets/user_playlist.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../riverpod/tab.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                scrolledUnderElevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    ref.invalidate(countProvider);
                  },
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          'My Playlists',
                          style: TextStyle(
                              fontWeight: CustomColors.extraBold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 30),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.plus),
                          color: Theme.of(context).primaryColor,
                          iconSize: 25,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AddPlaylist();
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: UserPlaylist(),
                  )
                ],
              )),
        );
      },
    );
  }
}
