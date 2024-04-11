import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/riverpod/song_provider.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../../model/song.dart';

class SongInfo extends ConsumerStatefulWidget {
  const SongInfo({super.key, required this.song});

  final Song song;

  @override
  // ignore: library_private_types_in_public_api
  _SongInfoState createState() => _SongInfoState();
}

class _SongInfoState extends ConsumerState<SongInfo> {
  Color glowColor = Colors.white;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ref.watch(audioHandlerProvider.notifier).setSong(widget.song),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 180,
            width: 180,
            child: Stack(children: [
              CustomColors.glowEffect(glowColor),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.song.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Text(
            widget.song.title,
            style: TextStyle(
              fontWeight: CustomColors.semiBold,
              color: Theme.of(context).primaryColor,
              fontFamily: 'Gilroy',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            widget.song.artist,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontFamily: 'Gilroy',
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
