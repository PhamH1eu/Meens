import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPlaylist extends StatelessWidget {
  const UserPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed('/playlist'),
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
