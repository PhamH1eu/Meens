import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utilities/provider.dart';

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
          body: const Center(
            child: IconButton(onPressed: signOut, icon: Icon(Icons.logout)),
          ),
        );
      },
    );
  }
}

Future signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
}
