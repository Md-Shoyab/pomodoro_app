import 'dart:async';
import 'package:get/get.dart';

class TimeController extends GetxController {
  static const int pomodoroDurationSeconds = 1500;
  final RxInt _remainingSeconds = pomodoroDurationSeconds.obs;
  final RxBool _isRunning = false.obs;
  Timer? _timer;

  String get formattedTime {
    final minutes = (_remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get isRunning => _isRunning.value;

  RxBool get isRunningRx => _isRunning;

  RxInt get remainingSecondsRx => _remainingSeconds;


  //   void setDurations(int workMinutes, int breakMinutes) {
  //   workDuration = workMinutes * 60;
  //   breakDuration = breakMinutes * 60;
  //   remainingTime = isWorkSession ? workDuration : breakDuration;
  //   update();
  // }

  void startTimer() {
    if (_timer?.isActive ?? false) return;
    _setRunning(true);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _onTick());
  }

  void pauseTimer() {
    _timer?.cancel();
    _setRunning(false);
  }

  void resetTimer() {
    _timer?.cancel();
    _remainingSeconds.value = pomodoroDurationSeconds;
    _setRunning(false);
  }

  void _onTick() {
    if (_remainingSeconds.value > 0) {
      _remainingSeconds.value--;
    } else {
      _timer?.cancel();
      _setRunning(false);
    }
  }

  void _setRunning(bool value) {
    _isRunning.value = value;
  }
}
