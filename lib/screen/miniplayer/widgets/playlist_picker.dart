import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/firebase/cloud_store/store.dart';
import 'package:webtoon/model/song.dart';
import 'package:webtoon/riverpod/song_provider.dart';

class PlaylistPicker extends ConsumerWidget {
  const PlaylistPicker({super.key});

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
            key: UniqueKey(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot playlist = snapshot.data!.docs[index];
              return StreamBuilder(
                stream: playlist.reference.collection('Songs').snapshots(),
                builder: (context, snapshot) {
                  List<Song> songs = [];
                  if (snapshot.hasData) {
                    for (var doc in snapshot.data!.docs) {
                      Storage.getSongUrl(doc['title']).then((songPath) =>
                          Storage.getSongAvatarUrl(doc['title']).then(
                              (imageUrl) => songs.add(
                                  Song.fromJson(doc, imageUrl, songPath))));
                    }
                  }
                  return GestureDetector(
                    onTap: () => addSongToPlaylist(playlist.reference,
                        ref.watch(audioHandlerProvider).currentSong),
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

  void addSongToPlaylist(DocumentReference playlist, Song song) async {
    String message = '';
    var doc = await playlist.collection('Songs').doc(song.title).get();
    if(doc.exists) {
      message = 'Song already exists in playlist';
    } else {
      await playlist.collection('Songs').doc(song.title).set(song.toJson());
      message = 'Song added to playlist';
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[400],
        webPosition: "center",
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
