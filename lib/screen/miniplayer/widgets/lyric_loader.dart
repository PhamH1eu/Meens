import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webtoon/riverpod/song_provider.dart';
import 'package:webtoon/screen/miniplayer/widgets/progress_bar.dart';

import '../../../model/lyric.dart';
import '../../../riverpod/lyric_provider.dart';
import '../../../riverpod/position_provider.dart';

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

class LyricLoader extends ConsumerStatefulWidget {
  const LyricLoader({super.key});

  @override
  LyricLoaderState createState() => LyricLoaderState();
}

class LyricLoaderState extends ConsumerState<LyricLoader> {
  late List<LyricLine> lyricsList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final positionData = ref.watch(positionDataProvider);
    final futureLyric = ref.watch(lyricProvider);
    return futureLyric.when(
      data: (lyric) {
        lyricsList = parseApiResponse(lyric);
        print(lyricsList.toString());
        return Padding(
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
                  return position.inSeconds <= timestamp.inSeconds;
                  // || position.inSeconds >= timestamp.inSeconds; cai nay lam cho no return 0 luon
                });
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 20,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    if (currentIndex == -1) {
                      return GestureDetector(
                        onTap: () {
                          // Seek to the timestamp of the tapped lyric
                          Duration timestamp = Duration(
                              minutes: int.parse(
                                  lyricsList[lyricsList.length + (index - 7)]
                                      .timestamp
                                      .split(':')[0]),
                              seconds: int.parse(
                                  lyricsList[lyricsList.length + (index - 7)]
                                      .timestamp
                                      .split(':')[1]
                                      .split('.')[0]),
                              milliseconds: int.parse(
                                  lyricsList[lyricsList.length + (index - 7)]
                                      .timestamp
                                      .split('.')[1]));
                          ref
                              .read(audioHandlerProvider.notifier)
                              .seek(timestamp);
                        },
                        child: Text(
                            lyricsList[lyricsList.length + (index - 7)].lyrics,
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).secondaryHeaderColor)),
                      );
                    }
                    if (currentIndex - 3 + index < 0 ||
                        currentIndex - 3 + index >= lyricsList.length) {
                      return Text("...",
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).secondaryHeaderColor));
                    }
                    return GestureDetector(
                      onTap: () {
                        // Seek to the timestamp of the tapped lyric
                        Duration timestamp = Duration(
                            minutes: int.parse(
                                lyricsList[currentIndex - 3 + index]
                                    .timestamp
                                    .split(':')[0]),
                            seconds: int.parse(
                                lyricsList[currentIndex - 3 + index]
                                    .timestamp
                                    .split(':')[1]
                                    .split('.')[0]),
                            milliseconds: int.parse(
                                lyricsList[currentIndex - 3 + index]
                                    .timestamp
                                    .split('.')[1]));
                        ref.read(audioHandlerProvider.notifier).seek(timestamp);
                      },
                      child: Text(
                        lyricsList[currentIndex - 3 + index].lyrics,
                        style: TextStyle(
                            fontSize: 20,
                            color: index == 2
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).secondaryHeaderColor),
                      ),
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
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Center(
          child: Text(
            'This song currently does not have lyrics available.',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
