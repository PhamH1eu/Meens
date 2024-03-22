import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:webtoon/recognition/shazam.dart';

import '../model/song_recognized.dart';

class Recent extends StatefulWidget {
  const Recent({super.key, required this.resultSong});

  final HashSet<ResultSong> resultSong;

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  GridTile buildGridTile(ResultSong e) {
    return GridTile(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(e.images), fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: Text(
                  e.name,
                  style: const TextStyle(
                    color: Color.fromRGBO(9, 17, 39, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                child: Text(
                  e.artist,
                  style: const TextStyle(
                    color: Color.fromRGBO(9, 17, 39, 1),
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        color: Color.fromRGBO(242, 241, 246, 1),
      ),
      child: Column(
        children: [
          const Text(
            "Recent found songs",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(9, 17, 39, 1)),
          ),
          Flexible(
            child: GridView.count(
              padding: const EdgeInsets.only(top: 10),
              childAspectRatio: 0.7,
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: resultSong.map((ResultSong e) {
                return buildGridTile(e);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
