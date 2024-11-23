import 'package:vlc_sync/entities/media_player_state.dart';

class MediaPlayer {
  final Duration time;
  final MediaPlayerState state;

  const MediaPlayer({
    required this.time,
    required this.state,
  });
}
