import 'dart:async';
import 'package:get/get.dart';

class TimeController extends GetxController {
  static const int pomodoroDuration = 1500;
  var remainingSeconds = pomodoroDuration.obs;
  Timer? _timer;
  RxBool isRunning = false.obs;

  String get formattedTime {
    final minute = (remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minute:$seconds';
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;
    isRunning.value = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
        isRunning.value = false;
      }
    });
  }

  void resetTimer() {
    remainingSeconds.value = pomodoroDuration;
    _timer?.cancel();
    isRunning.value = false;
    update();
  }

  void pauseTimer() {
    _timer?.cancel();
    isRunning = false.obs;
    update();
  }
}
