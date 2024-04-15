import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddPlaylist extends StatelessWidget {
  AddPlaylist({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text('Create Playlist',
          style: TextStyle(color: Theme.of(context).primaryColor)),
      content: TextField(
        controller: _controller,
        style: TextStyle(color: Theme.of(context).primaryColor),
        decoration: const InputDecoration(
          hintText: 'Enter Playlist Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            createPlaylist();
            Navigator.pop(context);
          },
          child: Text('Create',
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }

  void createPlaylist() async {
    await FirebaseFirestore.instance
        .collection(
            '/Users/${FirebaseAuth.instance.currentUser!.email}/Playlists/')
        .add({'title': _controller.text.trim()});
  }
}
