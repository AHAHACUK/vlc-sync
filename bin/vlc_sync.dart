import 'package:vlc_sync/entities/arguments.dart';
import 'package:vlc_sync/http_media_controller.dart';
import 'package:vlc_sync/media_syncer.dart';
import 'package:vlc_sync/ticker.dart';

void main(List<String> argumentsRaw) {
  final arguments = Arguments.parse(argumentsRaw);
  if (arguments == null) {
    print('Arguments error');
    return;
  }
  final mirrorMediaController = HttpMediaController(
    hostUrl: arguments.mirrorUrl,
    password: arguments.mirrorPassword,
  );
  final targetMediaController = HttpMediaController(
    hostUrl: arguments.targetUrl,
    password: arguments.targetPassword,
  );

  final syncer = MediaSyncer(
    maxSecondsDifference: 1,
    mirrorController: mirrorMediaController,
    targetController: targetMediaController,
  );

  final ticker = Ticker(
    onTick: () => syncer.sync(),
    interval: Duration(
      milliseconds: arguments.interval,
    ),
  );
  ticker.start();
}
