import 'dart:async';

class Ticker {
  final Future<void> Function() onTick;
  final Duration interval;

  Timer? _timer;

  Ticker({
    required this.onTick,
    required this.interval,
  });

  void start() {
    _timer = Timer(interval, tick);
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void tick() async {
    await onTick.call();
    start();
  }
}
