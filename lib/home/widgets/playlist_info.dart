import 'package:flutter/material.dart';
import 'package:webtoon/utilities/color.dart';

import '../../model/playlist.dart';

class PlaylistInfo extends StatefulWidget {
  const PlaylistInfo({super.key, required this.playlist});

  final Playlist playlist;

  @override
  State<PlaylistInfo> createState() => _PlaylistInfoState();
}

class _PlaylistInfoState extends State<PlaylistInfo> {
  Color glowColor = Colors.black;
  @override
  void initState() {
    super.initState();
    CustomColors.generatePaletteColor(widget.playlist.artwork).then((value) {
      if (mounted) {
        setState(() {
          glowColor = value;
        });
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  image: AssetImage(widget.playlist.artwork),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        Text(
          widget.playlist.title,
          style: const TextStyle(
            fontWeight: CustomColors.semiBold,
            color: CustomColors.mainText,
            fontFamily: 'Gilroy',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
