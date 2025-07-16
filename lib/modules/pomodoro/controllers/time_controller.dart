import 'dart:async';

import 'package:get/get.dart';

class TimeController extends GetxController {
  final RxInt _remainingSeconds = 1500.obs;
  final RxBool _isRunning = false.obs;
  final RxBool _isWorkSession = true.obs;

  late int _workDuration;
  late int _breakDuration;
  Timer? _timer;

  String get formattedTime {
    final duration = Duration(seconds: _remainingSeconds.value);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String get sessionLabel => _isWorkSession.value ? "Work" : "Break";
  bool get isRunning => _isRunning.value;

  void setDurations(int workMinutes, int breakMinutes) {
    _workDuration = workMinutes * 60;
    _breakDuration = breakMinutes * 60;
    _isWorkSession.value = true;
    _remainingSeconds.value = _workDuration;
    _setRunning(false);
  }

  void startTimer() {
    if (_timer?.isActive ?? false) return;
    _setRunning(true);
    _timer = Timer.periodic(Duration(seconds: 1), (_) => _onTick());
  }

  void pauseTimer() {
    _timer?.cancel();
    _setRunning(false);
  }

  void toggleTimer() => isRunning ? pauseTimer() : startTimer();

  void resetTimer() {
    _timer?.cancel();
    _remainingSeconds.value = _isWorkSession.value ? _workDuration : _breakDuration;
    _setRunning(false);
  }

  void _onTick() {
    if (_remainingSeconds.value > 0) {
      _remainingSeconds.value--;
    } else {
      _timer?.cancel();
      _isWorkSession.toggle();
      _remainingSeconds.value = _isWorkSession.value ? _workDuration : _breakDuration;
      startTimer(); // auto-switch
    }
  }

  void _setRunning(bool value) {
    _isRunning.value = value;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
