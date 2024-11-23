import 'package:vlc_sync/entities/media_player.dart';
import 'package:vlc_sync/http_media_controller.dart';

class MediaSyncer {
  final int maxSecondsDifference;
  final HttpMediaController mirrorController;
  final HttpMediaController targetController;

  MediaSyncer({
    required this.mirrorController,
    required this.targetController,
    required this.maxSecondsDifference,
  });

  Future<void> sync() async {
    final targetFuture = targetController.getCurrentMediaPlayer();
    final mirrorFuture = mirrorController.getCurrentMediaPlayer();
    final target = await targetFuture;
    final mirror = await mirrorFuture;
    if (target == null || mirror == null) return;
    _syncState(target, mirror);
    _syncTimeline(target, mirror);
  }

  Future<void> _syncState(
    MediaPlayer target,
    MediaPlayer mirror,
  ) async {
    final targetState = target.state;
    final mirrorState = mirror.state;
    if (targetState != mirrorState) {
      await mirrorController.togglePause();
      print("Synced pause state: Was $mirrorState, Now $targetState");
    }
  }

  Future<void> _syncTimeline(
    MediaPlayer target,
    MediaPlayer mirror,
  ) async {
    final targetTime = target.time.inSeconds;
    final mirrorTime = mirror.time.inSeconds;
    if ((targetTime - mirrorTime).abs() > maxSecondsDifference) {
      await targetController.setTime(targetTime);
      await mirrorController.setTime(targetTime);
      print("Synced time: Was $mirrorTime, Now $targetTime");
    }
  }
}
