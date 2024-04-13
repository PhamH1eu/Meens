import 'dart:collection';

import 'package:flutter/material.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({super.key, required this.selectedGenres});
  final HashSet<String> selectedGenres;

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  List<String> imagePath = [
    'indie',
    'pop',
    'edm',
    'country',
    'classic',
    'remix',
    'rap',
    'jazz',
    'rock',
    'disco',
  ];

  void selectGenres(String genre) {
    setState(() {
      if (widget.selectedGenres.contains(genre)) {
        widget.selectedGenres.remove(genre);
      } else {
        widget.selectedGenres.add(genre);
      }
    });
  }

  GridTile buildGridTile(String e) {
    return GridTile(
      child: InkWell(
        onTap: () {
          selectGenres(e);
        },
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: AssetImage('assets/genres/$e.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    e.split('/').last.split('.').first.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      selectGenres(e);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(28, 28),
                      elevation: 0,
                      side: const BorderSide(
                        color: Colors.white, // <-- Border color
                        width: 2,
                      ),
                      shape: const CircleBorder(),
                      backgroundColor: widget.selectedGenres.contains(e)
                          ? Colors.white
                          : Colors.transparent, // <-- Button color
                      foregroundColor: Colors.blue, // <-- Splash color
                    ),
                    child: Icon(
                      widget.selectedGenres.contains(e) ? Icons.check : null,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Text(
              "What are you interested in?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: imagePath.map((String e) {
                return buildGridTile(e);
              }).toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
