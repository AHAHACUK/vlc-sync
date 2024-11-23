class Arguments {
  final String mirrorUrl;
  final String mirrorPassword;
  final String targetUrl;
  final String targetPassword;
  final int interval;

  const Arguments({
    required this.mirrorUrl,
    required this.mirrorPassword,
    required this.targetUrl,
    required this.targetPassword,
    required this.interval,
  });

  static Arguments? parse(List<String> arguments) {
    try {
      late final String targetUrl;
      late final String targetPassword;
      late final String mirrorUrl;
      late final String mirrorPassword;
      late final int interval;
      for (var i = 0; i < arguments.length; i++) {
        final arg = arguments[i];
        if (arg == '-target') {
          final url = arguments[i + 1];
          final password = arguments[i + 2];
          targetUrl = url;
          targetPassword = password;
        } else if (arg == '-mirror') {
          final url = arguments[i + 1];
          final password = arguments[i + 2];
          mirrorUrl = url;
          mirrorPassword = password;
        } else if (arg == '-interval') {
          final value = int.parse(arguments[i + 1]);
          interval = value;
        }
      }
      return Arguments(
        targetUrl: targetUrl,
        targetPassword: targetPassword,
        mirrorUrl: mirrorUrl,
        mirrorPassword: mirrorPassword,
        interval: interval,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }
}
