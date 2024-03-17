import 'package:flutter/material.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../model/song.dart';

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
    // CustomColors.generatePaletteColor(widget.song.artWork).then((value) {
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
          height: 130,
          width: 130,
          child: Stack(children: [
            CustomColors.glowEffect(glowColor),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(widget.song.artWork),
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
    );
  }
}
