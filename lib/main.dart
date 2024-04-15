import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:page_transition/page_transition.dart';
import 'package:webtoon/model/playlist.dart';

import 'package:webtoon/screen/auth/login_screen.dart';
import 'package:webtoon/layout.dart';
import 'package:webtoon/screen/miniplayer/play_screen.dart';
import 'package:webtoon/model/song_recognized.dart';
import 'package:webtoon/screen/onboard/onboard_screen.dart';
import 'package:webtoon/screen/playlist/playlist_info.dart';
import 'package:webtoon/screen/recognition/shazam.dart';
import 'package:webtoon/utilities/fonts.dart';

import 'screen/auth/signup_screen.dart';
import 'firebase_options.dart';
import 'screen/recognition/result.dart';
import 'riverpod/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.meens.myapp.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode ? CustomColors().darkTheme : CustomColors().lightTheme,
      home: const MyHomePage(),
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/login':
            return PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
              reverseDuration: const Duration(seconds: 1),
            );
          case '/signup':
            return PageTransition(
              child: SignUpPage(title: args as String),
              type: PageTransitionType.rightToLeft,
              settings: settings,
              reverseDuration: const Duration(seconds: 1),
            );
          case '/home':
            return PageTransition(
              child: const Layout(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          case '/app':
            return PageTransition(
              child: const MyHomePage(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          case '/play':
            return PageTransition(
              child: const PlayingScreen(),
              type: PageTransitionType.bottomToTop,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          case '/recog':
            return PageTransition(
              child: const Shazam(),
              type: PageTransitionType.rightToLeft,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          case '/result':
            return PageTransition(
              child: ShazamResult(
                resultSong: args as ResultSong,
              ),
              type: PageTransitionType.fade,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          case '/playlist':
            return PageTransition(
              child: PlaylistInfo(
                playlist: args as Playlist,
              ),
              type: PageTransitionType.fade,
              settings: settings,
              reverseDuration: const Duration(milliseconds: 250),
            );
          default:
            return null;
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        } else {
          return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Users')
                .where('email', isEqualTo: snapshot.data!.email)
                .get()
                .then((value) => value.docs.first.get('firstTime')),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,));
              }
              return snapshot.data ? const OnboardScreen() : const Layout();
            },
          );
        }
      },
    );
  }
}
