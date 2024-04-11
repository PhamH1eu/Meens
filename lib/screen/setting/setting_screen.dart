import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:webtoon/riverpod/song_provider.dart';

import '../../riverpod/tab.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
            title: const Text('Settings'),
          ),
          body: Center(
            child: IconButton(
                onPressed: () async {
                  await signOut();
                  if (context.mounted) Navigator.of(context).pop();
                  ref.invalidate(countProvider);
                  ref.read(audioHandlerProvider.notifier).clear();
                },
                icon: const Icon(Icons.logout)),
          ),
        );
      },
    );
  }
}

//fuck this shit
Future signOut() async {
  if (GoogleSignIn().currentUser != null) {
    await GoogleSignIn().disconnect();
  } else {
    await FirebaseAuth.instance.signOut();
  }
}
