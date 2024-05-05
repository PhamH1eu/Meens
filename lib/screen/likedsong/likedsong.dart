import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/screen/likedsong/widgets/like_song.dart';
import 'package:webtoon/utilities/fonts.dart';
import 'package:webtoon/firebase/cloud_store/store.dart';
import '../../model/song.dart';
import '../../riverpod/tab.dart';

class LikedSong extends ConsumerWidget {
  const LikedSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }

        List<String> listName = [];
        try {
          listName = List<String>.from(snapshot.data!['likedSong']);
        } catch (e) {
          // this is normal, it is laggy a bit when the user is first time
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Songs')
              .where('title', whereIn: listName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              );
            }

            final List<Song> likedsong = [];
            final futures = <Future>[];

            for (var docSnapshot in snapshot.data!.docs) {
              final future = Storage.getSongUrl(docSnapshot['title'])
                  .then((songPath) {
                return Storage.getSongAvatarUrl(docSnapshot['title'])
                    .then((imageUrl) {
                  likedsong.add(Song.fromJson(docSnapshot, imageUrl, songPath));
                });
              });

              futures.add(future);
            }

            return FutureBuilder(
              future: Future.wait(futures),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  );
                }

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
                        actions: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.filter_list),
                            onPressed: () {
                              // Xử lý khi nút "filter" được nhấn
                            },
                          ),
                        ],
                      ),
                      body: Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            Text(
                              'Liked Songs',
                              style: TextStyle(
                                fontWeight: CustomColors.extraBold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 25,
                                fontFamily: 'Gilroy',
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: MediaQuery.of(context)
                                      .size
                                      .width /
                                      (MediaQuery.of(context).size.height /
                                          1.65),
                                ),
                                itemCount: likedsong.length,
                                itemBuilder: (context, index) {
                                  return LikeSongInfo(song: likedsong[index]);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}