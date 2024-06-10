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
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                subtitle: const Text('English (United States)'),
                onTap: () {
                  // Handle language change
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('Notifications'),
                subtitle: const Text('Email, Newsletter etc'),
                trailing: Switch(
                  value: true, // Set this value based on your logic
                  onChanged: (bool value) {
                    // Handle switch state change
                  },
                ),
                onTap: () {
                  // Handle notification settings change
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy'),
                subtitle: const Text('Terms, Privacy'),
                onTap: () {
                  // Handle privacy settings change
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.support_agent),
                title: const Text('Support'),
                subtitle: const Text('24/7 Customer'),
                onTap: () {
                  // Handle support settings change
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.contact_mail),
                title: const Text('Contact Us'),
                onTap: () {
                  // Handle contact us action
                },
              ),
              const Divider(),
              Center(
                child: TextButton(
                  onPressed: () async {
                    await signOut();
                    //Chạy ở mobile thì comment lại
                    // if (context.mounted) Navigator.of(context).pop();
                    ref.invalidate(countProvider);
                    ref.read(audioHandlerProvider.notifier).clear();
                    ref.invalidate(recommendedSongsProvider);
                  },
                  child: const Text('Sign Out'),
                ),
              ),
            ],
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