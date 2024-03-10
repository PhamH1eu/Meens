import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import 'package:webtoon/auth/login_screen.dart';
import 'package:webtoon/layout.dart';
import 'package:webtoon/utilities/fonts.dart';

import 'auth/signup_screen.dart';
import 'firebase_options.dart';
import 'utilities/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          case '/app':
            return PageTransition(
              child: const MyHomePage(),
              type: PageTransitionType.rightToLeft,
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
          return const Layout();
        }
      },
    );
  }
}
