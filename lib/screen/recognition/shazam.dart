// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:collection';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webtoon/screen/recognition/recent.dart';
import 'package:another_audio_recorder/another_audio_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/post_song_api.dart';
import '../../model/song_recognized.dart';

HashSet<ResultSong> resultSong = HashSet();

class Shazam extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  const Shazam({super.key, localFileSystem})
      : localFileSystem = localFileSystem ?? const LocalFileSystem();

  @override
  State<Shazam> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Shazam> {
  bool isListening = false;
  bool notFound = false;
  bool isFinding = false;

  AnotherAudioRecorder? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;

  Future<void> fetchSong(audioFile, BuildContext context) async {
    try {
      final song = await SongApi.getRecipe(audioFile);
      setState(() {
        resultSong.add(song[0]);
      });
      if (context.mounted) {
        Navigator.pushNamed(context, '/result', arguments: song[0]);
      }
      notFound = false;
    } catch (e) {
      setState(() {
        notFound = true;
      });
    }
    _init();
  }

  @override
  void initState() {
    super.initState();
    _init();
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
              Text(
                isListening
                    ? 'Listening...'
                    : isFinding
                        ? 'Finding your song...'
                        : notFound
                            ? 'We didn\'t quite catch that'
                            : 'Tap to recognize your song',
                style: const TextStyle(
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
                      switch (_currentStatus) {
                        case RecordingStatus.Initialized:
                          {
                            setState(() {
                              isListening = true;
                            });
                            _start();
                            break;
                          }
                        case RecordingStatus.Recording:
                          {
                            setState(() {
                              isListening = false;
                              isFinding = true;
                            });
                            _stop(context);
                            break;
                          }
                        default:
                          break;
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
            ],
          ),
        ),
        SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24.0),
            topRight: Radius.circular(24.0),
          ),
          panel: Recent(
            resultSong: resultSong,
          ),
        ),
      ]),
    );
  }

  _init() async {
    isFinding = false;
    try {
      final status = await Permission.microphone.request();

      if (status != PermissionStatus.granted) {
        return;
      }

      String customPath = '/flutter_audio_recorder_';
      io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
      if (io.Platform.isIOS) {
        appDocDirectory = await getApplicationDocumentsDirectory();
      } else {
        appDocDirectory = (await getExternalStorageDirectory())!;
      }

      // can add extension like ".mp4" ".wav" ".m4a" ".aac"
      customPath = appDocDirectory.path +
          customPath +
          DateTime.now().millisecondsSinceEpoch.toString();

      // .wav <---> AudioFormat.WAV
      // .mp4 .m4a .aac <---> AudioFormat.AAC
      // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
      _recorder =
          AnotherAudioRecorder(customPath, audioFormat: AudioFormat.WAV);

      await _recorder!.initialized;
      // after initialization
      var current = await _recorder!.current(channel: 0);
      print(current);
      // should be "Initialized", if all working fine
      setState(() {
        _current = current;
        _currentStatus = current!.status!;
        print(_currentStatus);
      });
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);
        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _stop(BuildContext context) async {
    var result = await _recorder!.stop();
    File file = widget.localFileSystem.file(result!.path);
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
    if (context.mounted) fetchSong(file, context);
    file.delete();
  }
}
