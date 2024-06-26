import 'package:flutter/material.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../../../model/playlist.dart';

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
    // CustomColors.generatePaletteColor(widget.playlist.artwork).then((value) {
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
          height: 180,
          width: 180,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/album.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
        ),
        const SizedBox(height: 10),
        Text(
          widget.playlist.title,
          style: TextStyle(
            fontWeight: CustomColors.semiBold,
            color: Theme.of(context).primaryColor,
            fontFamily: 'Gilroy',
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
