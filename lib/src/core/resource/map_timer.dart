import 'dart:async';
import '../util/numbers.dart';

class MapTimer {
  MapTimer(Function(Timer) function) {
    Timer.periodic(
      const Duration(
        seconds: Numbers.mapTimerDuration,
      ),
      function,
    );
  }

  static MapTimer? _instance;

  static MapTimer getInstance(Function(Timer) function) {
    _instance ??= MapTimer(function);
    return _instance!;
  }
}
