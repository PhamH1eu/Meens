import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webtoon/riverpod/song_provider.dart';
import 'package:webtoon/screen/miniplayer/widgets/progress_bar.dart';

//create a PositionData riverpod provider
final positionDataProvider = Provider<Stream<PositionData>>((ref) {
  final audioHandlers = ref.watch(audioHandlerProvider);
  final audioPlayer = audioHandlers.audioPlayer;
  return Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      audioPlayer.positionStream,
      audioPlayer.bufferedPositionStream,
      audioPlayer.durationStream,
      (position, bufferedPosition, duration) =>
          PositionData(position, bufferedPosition, duration ?? Duration.zero),
    ).asBroadcastStream();
});