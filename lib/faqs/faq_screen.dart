import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/utilities/fonts.dart';

import '../utilities/provider.dart';

class FAQ extends StatelessWidget {
  const FAQ({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                ref.invalidate(countProvider);
              },
            ),
            title: Text(
              'FAQ',
              style: TextStyle(
                  fontWeight: CustomColors.extraBold,
                  color: Theme.of(context).primaryColor),
            ),
            centerTitle: true,
          ),
          body: Container(
            color: Theme.of(context).focusColor,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Text(
                      "Downloading",
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "Can i download or cache my music",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    children: [
                      Text(
                        "Yes, Meens allows you downloading or caching music at your devices. In order to play music, you must have a working internet connection first in order to download",
                        style: TextStyle(
                            fontFamily: 'Gilroy',
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text("Playback",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: CustomColors.extraBold,
                          fontSize: 20,
                        )),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "Does Musi use mydata",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I enable crossfade?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I adjust playback speed?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Playlists",
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I add tracks to my playlist",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I create a new playlist",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I delete a playlist",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Tracks",
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I delete tracks?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I edit a track name or artist?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I play age restricted tracks?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "Transfer/Backup",
                      style: TextStyle(
                          fontWeight: CustomColors.extraBold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                  ExpansionTile(
                    collapsedBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        ),
                        top: BorderSide(
                          color: Colors.grey,
                          width: 0.5,
                        )),
                    expandedAlignment: Alignment.centerLeft,
                    childrenPadding: const EdgeInsets.only(left: 16, right: 16),
                    title: Text(
                      "How can I transfer my library and playlists to a new device?",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    children: [
                      Text(
                        "sii",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
