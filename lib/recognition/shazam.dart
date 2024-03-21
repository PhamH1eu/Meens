// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';
import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:webtoon/recognition/recent.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';

import '../model/song_recognized.dart';

class Shazam extends StatefulWidget {
  final LocalFileSystem localFileSystem;

  const Shazam({super.key, localFileSystem}) : localFileSystem = localFileSystem ?? const LocalFileSystem();

  @override
  State<Shazam> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Shazam> {
  bool isListening = false;
  bool isRecorderReady = false;
  String audioPath = '';

  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;


  ResultSong song = ResultSong(name: '', images: '', artist: '');

  // Future<void> fetchSong() async {
    // final audioFile = File(audioPath);
    // final song = await SongApi.getRecipe(audioFile);
    // setState(() {
    //   this.song = song[0];
    //   log(song.toString());
    // });
  // }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future<void> start() async {
  //   if (!isRecorderReady) {
  //     await recorder.start();
  //   }
  // }

  // Future stop() async {
  //   if (!isRecorderReady) {
  //     return;
  //   }
  //   var result = await recorder.stop();
  //   File file = widget.localFileSystem.file(result.path);
  //   setState(() {
  //     audioPath = path!;
  //   });
  //   fetchSong();
  // }

  // Future<void> initRecorder() async {
  //   final status = await Permission.microphone.request();

  //   if (status != PermissionStatus.granted) {
  //     return;
  //   }

  //   await recorder.initialized;
  //   isRecorderReady = true;
  // }

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
                      // if (recorder.isRecording) {
                      //   await stop();
                      //   setState(() {
                      //     isListening = false;
                      //   });
                      // } else {
                      //   await start();
                      //   setState(() {
                      //     isListening = true;
                      //   });
                      // }
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
                  Navigator.pushNamed(context, '/result', arguments: song);
                },
                icon: const Icon(Icons.close, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        switch (_currentStatus) {
                          case RecordingStatus.Initialized:
                            {
                              _start();
                              break;
                            }
                          case RecordingStatus.Recording:
                            {
                              _pause();
                              break;
                            }
                          case RecordingStatus.Paused:
                            {
                              _resume();
                              break;
                            }
                          case RecordingStatus.Stopped:
                            {
                              _init();
                              break;
                            }
                          default:
                            break;
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlue,
                          )),
                      child: _buildText(_currentStatus),
                    ),
                  ),
                  TextButton(
                    onPressed:
                    _currentStatus != RecordingStatus.Unset ? _stop : null,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blueAccent.withOpacity(0.5),
                        )),
                    child:
                    const Text("Stop", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                ],
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

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
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
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;
        // after initialization
        var current = await _recorder!.current(channel: 0);
        log(current as String);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
          log(_currentStatus as String);
        });
      }
    } catch (e) {
      log(e as String);
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
        // log(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      log(e as String);
    }
  }

  _resume() async {
    await _recorder!.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder!.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder!.stop();
    log("Stop recording: ${result!.path}");
    log("Stop recording: ${result.duration}");
    File file = widget.localFileSystem.file(result.path);
    log("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Init';
          break;
        }
      default:
        break;
    }
    return Text(text, style: const TextStyle(color: Colors.white));
  }
}
