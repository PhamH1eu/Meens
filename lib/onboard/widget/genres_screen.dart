import 'dart:collection';

import 'package:flutter/material.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  List<String> imagePath = [
    'assets/genres/indie.jpg',
    'assets/genres/pop.jpg',
    'assets/genres/edm.jpg',
    'assets/genres/country.jpg',
    'assets/genres/classic.jpg',
    'assets/genres/remix.jpg',
    'assets/genres/rap.jpg',
    'assets/genres/jazz.jpg',
    'assets/genres/rock.jpg',
    'assets/genres/disco.jpg',
  ];

  HashSet<String> selectedGenres = HashSet();

  void selectGenres(String genre) {
    setState(() {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      } else {
        selectedGenres.add(genre);
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
                image: AssetImage(e),
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
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      selectGenres(e);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(30, 30),
                      elevation: 0,
                      side: const BorderSide(
                        color: Colors.white, // <-- Border color
                        width: 2,
                      ),
                      shape: const CircleBorder(),
                      backgroundColor: selectedGenres.contains(e)
                          ? Colors.white
                          : Colors.transparent, // <-- Button color
                      foregroundColor: Colors.blue, // <-- Splash color
                    ),
                    child: Icon(
                      selectedGenres.contains(e) ? Icons.check : null,
                      size: 20,
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
