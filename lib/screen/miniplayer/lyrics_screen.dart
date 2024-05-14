import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/screen/miniplayer/widgets/control_button.dart';
import '../../riverpod/position_provider.dart';
import '../../riverpod/song_provider.dart';
import 'widgets/progress_bar.dart';

// Define a class to hold lyrics and timestamp
class LyricLine {
  final String timestamp;
  final String lyrics;

  LyricLine({required this.timestamp, required this.lyrics});
}

String apiResponse =
    "[00:00.72]Go-go-go-go-go-gods\n[00:07.23]Go-go-go-go-go-gods\n[00:13.68]Ay, this is what you came for, blood on the game ball\n[00:17.35]Everybody dropping like rainfall\n[00:20.14]Uh, this is your moment, eyes on the pulpit, kid\n[00:24.30]Think church just opened\n[00:26.69]And they're singing your praises, la-la-la\n[00:30.32]Screaming your name out lo-lo-loud\n[00:33.78]One more step, you're immortal now, 'cause\n[00:38.75]Once you play God, once you play God\n[00:42.02]They're gonna crumble one by one\n[00:45.11]Then we gon' ride right into the sun\n[00:48.12]Like it's the day my kingdom come\n[00:51.89]Baby, we're go-go-go-go-go-gods\n[00:58.57]Yeah, we're go-go-go-go-go-gods\n[01:06.26]Ay, welcome to the big show, next on the ladder\n[01:09.94]Is it your name in the rafters?\n[01:12.71]Brief-brief-brief moment of silence\n[01:16.05]Bad girl woke up and chose violence\n[01:19.30]And they're singing my praises, la-la-la\n[01:23.08]Screaming my name out lo-lo-loud\n[01:26.36]This is why we're immortal now, 'cause\n[01:31.38]Once you play God, once you play God\n[01:34.64]They're gonna crumble one by one (crumble one by one)\n[01:37.88]Then we gon' ride right into the sun\n[01:40.92]Like it's the day my kingdom come\n[01:44.35]Baby, we're go-go-go-go-go-gods\n[01:51.06]Yeah, we're go-go-go-go-go-gods\n[02:10.31]I'm on my knees, pray for glory\n[02:14.05]Anyone read this underdog story?\n[02:17.35]I can't lose myself again\n[02:20.53]Help me raise this heart\n[02:24.68]Heart, unbreakable\n[02:27.24]Once you play God, once you play God\n[02:30.59]They're gonna crumble one by one\n[02:33.63]Then we gon' ride right into the sun\n[02:36.84]Like it's the day my kingdom come\n[02:40.48]Once you play God, once you play God\n[02:43.55]They're gonna crumble one by one\n[02:46.83]Then we gon' ride right into the sun\n[02:49.93]Like it's the day my kingdom come\n[02:53.48]Baby, we're go-go-go-go-go-gods\n[03:00.05]Yeah, we're go-go-go-go-go-gods\n[03:08.25]Go-go-go-go-go-gods\n[03:13.17]Yeah, we're go-go-go-go-go-gods\n[03:33.02]Once you play\n";

List<LyricLine> parseApiResponse(String apiResponse) {
  List<LyricLine> lyricsList = [];
  // Split the response by newline characters
  List<String> lines = apiResponse.split('\n');
  // Extract timestamp and lyrics from each line
  for (var line in lines) {
    RegExp exp = RegExp(r"\[(\d+:\d+\.\d+)\](.*)");
    RegExpMatch? match = exp.firstMatch(line);
    if (match != null && match.groupCount == 2) {
      String timestamp = match.group(1)!;
      String lyrics = match.group(2)!;
      lyricsList.add(LyricLine(timestamp: timestamp, lyrics: lyrics));
    }
  }
  return lyricsList;
}

// try to rewrite the code so i can represent the lyrics in about 7 lines, 3 previous, 1 current, 3 next
// and the current line is always in the middle of the screen

// i will use the ListView.builder to achieve this
// i will also use the position of the current line to determine the index of the current line in the list

class LyricScreen extends ConsumerStatefulWidget {
  const LyricScreen({super.key});

  @override
  LyricScreenState createState() => LyricScreenState();
}

// Define a state class for the LyricScreen widget
class LyricScreenState extends ConsumerState<LyricScreen> {
  late List<LyricLine> lyricsList;

  @override
  void initState() {
    super.initState();
    lyricsList = parseApiResponse(apiResponse);
  }

  @override
  Widget build(BuildContext context) {
    final audioHandlers = ref.watch(audioHandlerProvider);
    final positionData = ref.watch(positionDataProvider);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Lyrics'),
          leading: IconButton(
            icon: const Icon(Icons.keyboard_arrow_down_sharp),
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,),
      body: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10, left: 10),
            visualDensity: const VisualDensity(vertical: 3),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://i.scdn.co/image/ab6761610000e5eb989ed05e1f0570cc4726c2d3",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              "GODS",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 17),
            ),
            subtitle: Text("New Jeans",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 15)),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<PositionData>(
              stream: positionData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Duration position = snapshot.data!.position;
                  int currentIndex = lyricsList.indexWhere((element) {
                    Duration timestamp = Duration(
                        minutes: int.parse(element.timestamp.split(':')[0]),
                        seconds: int.parse(
                            element.timestamp.split(':')[1].split('.')[0]),
                        milliseconds: int.parse(element.timestamp.split('.')[1]));
                    return position.inSeconds <= timestamp.inSeconds + 1;
                    // || position.inSeconds >= timestamp.inSeconds; cai nay lam cho no return 0 luon
                  });
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 20,),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 7,              
                    itemBuilder: (context, index) {
                      if (currentIndex == -1) {
                        return Text(
                            lyricsList[lyricsList.length + (index - 7)].lyrics,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).secondaryHeaderColor));
                      }
                      if (currentIndex - 3 + index < 0 ||
                          currentIndex - 3 + index >= lyricsList.length) {
                        return Text("...",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).secondaryHeaderColor));
                      }
                      return Text(
                        lyricsList[currentIndex - 3 + index].lyrics,
                        style: TextStyle(
                            fontSize: 20,
                            color: index == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).secondaryHeaderColor),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child:
                        Text("Music not playing", style: TextStyle(fontSize: 30)),
                  );
                }
              },
            ),
          ),
          const Spacer(),
          Padding(
                padding: const EdgeInsets.all(20.0),
                child: StreamBuilder<PositionData>(
                  stream: positionData,
                  builder: (context, snapshot) {
                    final positionData = snapshot.data;
                    if (positionData == null ||
                        audioHandlers.audioPlayer.duration == null) {
                    } else {
                      if (positionData.position >
                          audioHandlers.audioPlayer.duration! -
                              const Duration(milliseconds: 500)) {
                        // if (audioHandlers.audioPlayer.hasNext) {
                        //   carouselController.animateToPage(
                        //       audioHandlers.audioPlayer.nextIndex!);
                        // }
                      }
                    }
                    return ProgressBar(
                      barHeight: 5,
                      baseBarColor: Theme.of(context).secondaryHeaderColor,
                      bufferedBarColor: Theme.of(context).hintColor,
                      progressBarColor: Theme.of(context).primaryColor,
                      thumbColor: Theme.of(context).primaryColor,
                      timeLabelTextStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: 'Gilroy',
                        fontSize: 16.0,
                      ),
                      timeLabelLocation: TimeLabelLocation.above,
                      timeLabelPadding: 15,
                      progress: positionData?.position ?? Duration.zero,
                      buffered:
                          positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: audioHandlers.audioPlayer.seek,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Control(size: 59, carouselController: CarouselController()),
              ),
        ],
      ),
    );
  }
}
