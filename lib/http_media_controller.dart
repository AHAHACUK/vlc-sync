import 'package:http/http.dart' as http;
import 'package:vlc_sync/entities/media_player.dart';
import 'package:vlc_sync/entities/media_player_state.dart';
import 'package:xml/xml.dart';

class HttpMediaController {
  final String _hostUrl;
  final String authPassword;

  String get _baseUrl => "http://$_hostUrl";
  Map<String, String> get _headers => {
        "Authorization": "Basic $authPassword",
      };

  const HttpMediaController({
    required String hostUrl,
    required String password,
  })  : _hostUrl = hostUrl,
        authPassword = password;

  MediaPlayerState _mapState(String string) {
    return switch (string) {
      'paused' => MediaPlayerState.pause,
      'playing' => MediaPlayerState.playing,
      _ => throw UnimplementedError("Unexpected state")
    };
  }

  Future<MediaPlayer?> getCurrentMediaPlayer() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl/requests/status.xml"),
        headers: _headers,
      );
      final xml = XmlDocument.parse(response.body);
      final root = xml.getElement('root')!;
      return MediaPlayer(
        time: Duration(
          seconds: int.parse(root.getElement('time')!.innerText),
        ),
        state: _mapState(root.getElement('state')!.innerText),
      );
    } catch (e) {
      print("Unable to fetch state on $_baseUrl");
      return null;
    }
  }

  Future<void> togglePause() async {
    try {
      await http.get(
        Uri.parse("$_baseUrl/requests/status.xml?command=pl_pause"),
        headers: _headers,
      );
    } catch (e) {
      print("Unable to toggle pause on $_baseUrl");
    }
  }

  Future<void> setTime(int time) async {
    try {
      await http.get(
        Uri.parse("$_baseUrl/requests/status.xml?command=seek&val=$time"),
        headers: _headers,
      );
    } catch (e) {
      print("Unable to toggle pause on $_baseUrl");
    }
  }
}
