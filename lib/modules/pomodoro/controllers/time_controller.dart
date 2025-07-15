import 'dart:async';
import 'package:get/get.dart';

class TimeController extends GetxController {
  static const int defaultWorkDurationSeconds = 1500;
  static const int defaultBreakDurationSeconds = 300;

  int _workDuration = defaultWorkDurationSeconds;
  int _breakDuration = defaultBreakDurationSeconds;
  bool _isWorkSession = true;

  final RxInt _remainingSeconds = defaultWorkDurationSeconds.obs;
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

  void setDurations(int workMinutes, int breakMinutes) {
    _workDuration = workMinutes * 60;
    _breakDuration = breakMinutes * 60;
    _isWorkSession = true;
    _remainingSeconds.value = _workDuration;
    _setRunning(false);
  }

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
    _remainingSeconds.value = _isWorkSession ? _workDuration : _breakDuration;
    _setRunning(false);
  }

  void _onTick() {
    if (_remainingSeconds.value > 0) {
      _remainingSeconds.value--;
    } else {
      _timer?.cancel();
      _setRunning(false);
      // Optionally, switch between work and break sessions here
      // _isWorkSession = !_isWorkSession;
      // _remainingSeconds.value = _isWorkSession ? _workDuration : _breakDuration;
    }
  }

  void _setRunning(bool value) {
    _isRunning.value = value;
  }
}
