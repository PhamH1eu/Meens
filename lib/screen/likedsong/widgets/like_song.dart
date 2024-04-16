import 'package:flutter/material.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../../model/song.dart';

class LikeSongInfo extends StatefulWidget {
  const LikeSongInfo({super.key, required this.song});

  final Song song;

  @override
  State<LikeSongInfo> createState() => _LikeSongInfoState();
}

class _LikeSongInfoState extends State<LikeSongInfo> {
  Color glowColor = Colors.black;

  @override
  void initState() {
    super.initState();
    // CustomColors.generatePaletteColor(widget.song.imageUrl).then((value) {
    //   if (mounted) {
    //     setState(() {
    //       glowColor = value;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 140,
          width: 140,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(widget.song.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 9),
        Text(
          widget.song.title,
          style: TextStyle(
            fontWeight: CustomColors.semiBold,
            color: Theme.of(context).primaryColor,
            fontFamily: 'Gilroy',
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.song.artist,
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
            fontFamily: 'Gilroy',
            fontSize: 8,
          ),
        ),
      ],
    );
  }
}
