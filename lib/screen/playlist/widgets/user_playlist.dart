import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/model/playlist.dart';
import 'package:webtoon/model/song.dart';
import 'package:webtoon/riverpod/firebase_provider.dart';

class UserPlaylist extends ConsumerWidget {
  const UserPlaylist({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(
              '/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/')
          .snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ));
        }
        return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot playlist = snapshot.data!.docs[index];
              return StreamBuilder(
                stream: playlist.reference.collection('Songs').snapshots(),
                builder: (context, snapshot) {
                  List<Song> songs = [];
                  if (snapshot.hasData) {
                    ref.watch(getSongProvider(playlist.id)).whenData((result) {
                      songs.addAll(result);
                    });
                  }
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/playlist', arguments: Playlist(title: playlist['title'], songs: songs)),
                    child: ListTile(
                        visualDensity: const VisualDensity(vertical: 3),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://via.placeholder.com/150',
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          playlist['title'],
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17),
                        ),
                        subtitle: !snapshot.hasData
                            ? Text('Loading...',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15))
                            : Text('${snapshot.data!.docs.length} songs',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15))),
                  );
                },
              );
            });
      }),
    );
  }
}
