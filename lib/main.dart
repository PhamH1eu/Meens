import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import 'package:webtoon/auth/login_screen.dart';
import 'package:webtoon/layout.dart';

import 'auth/signup_screen.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android:
              PageTransition(type: PageTransitionType.rightToLeft, child: this)
                  .matchingBuilder,
        }),
      ),
      home: const MyHomePage(),
      onGenerateRoute: (settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/login':
            return PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 1),
            );
          case '/signup':
            return PageTransition(
              child: SignUpPage(title: args as String),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 1),
            );
          case '/app':
            return PageTransition(
              child: const MyHomePage(),
              type: PageTransitionType.theme,
              settings: settings,
              reverseDuration: const Duration(seconds: 1),
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
          return Layout();
        }
      },
    );
  }
}
