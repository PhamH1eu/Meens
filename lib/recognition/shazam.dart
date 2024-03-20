import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webtoon/recognition/recent.dart';

import '../model/post_song_api.dart';

class Shazam extends StatefulWidget {
  const Shazam({super.key});

  @override
  State<Shazam> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Shazam> {
  bool isListening = false;
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  String audioPath = '';

  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  Future<void> start() async {
    if (!isRecorderReady) {
      return;
    }
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) {
      return;
    }
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
  }

  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(55, 140, 231, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Stack(children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Tap to recognize your song',
                style: TextStyle(
                    color: Color.fromRGBO(247, 250, 255, 1), fontSize: 27),
              ),
              const SizedBox(
                height: 60,
              ),
              AvatarGlow(
                  glowCount: 3,
                  duration: const Duration(milliseconds: 1300),
                  animate: isListening,
                  glowRadiusFactor: 0.5,
                  glowColor: const Color.fromRGBO(247, 250, 255, 1),
                  child: GestureDetector(
                    onTap: () async {
                      if (recorder.isRecording) {
                        await stop();
                        setState(() {
                          isListening = false;
                        });
                      } else {
                        await start();
                        setState(() {
                          isListening = true;
                        });
                      }
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      padding: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Color.fromRGBO(99, 174, 255, 1),
                        color: Color.fromRGBO(247, 250, 255, 1),
                      ),
                      // child: Image.asset('assets/shazam.png'),
                      child: Image.asset('assets/icon.png'),
                    ),
                  )),
              IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/result');
                  RecipeApi.getRecipe();
                },
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          panel: const Recent(),
        ),
      ]),
    );
  }
}
