import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:webtoon/riverpod/firebase_provider.dart';
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
                  // Chay o web thi bat cai dong nay len, mobile thi comment lai
                  if (context.mounted) Navigator.of(context).pop();
                  ref.invalidate(countProvider);
                  ref.read(audioHandlerProvider.notifier).clear();
                  ref.invalidate(recommendedSongsProvider);
                },
                icon: const Icon(Icons.logout)),
          ),
        );
      },
    );
  }
}

Future signOut() async {
  if (GoogleSignIn().currentUser != null) {
    await GoogleSignIn().disconnect();
  } else {
    await FirebaseAuth.instance.signOut();
  }
}
