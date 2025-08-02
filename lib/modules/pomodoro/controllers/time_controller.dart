import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:pomodoro_app/constants/app_strings.dart';
import 'package:pomodoro_app/main.dart';

class TimeController extends GetxController {
  final RxInt _remainingSeconds = 1500.obs;
  final RxBool _isRunning = false.obs;
  final RxBool _isWorkSession = true.obs;

  late int _workDuration;
  late int _breakDuration;
  Timer? _timer;
  final player = AudioPlayer();

  String get formattedTime {
    final duration = Duration(seconds: _remainingSeconds.value);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String get sessionLabel => _isWorkSession.value ? AppString.workTime : AppString.breakTime;
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
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _onTick());
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
      _setRunning(false);

      _showNotification();
      _playAlarm();
    }
  }

  void _setRunning(bool value) {
    _isRunning.value = value;
  }

  void _playAlarm() async {
    try {
      debugPrint('~~~> Playing alarm sound from: ${AppString.alarmSoundPath}');
      await player.setSource(AssetSource(AppString.alarmSoundPath));
      await player.resume();
    } catch (e) {
      debugPrint('~~~> Alarm sound error: $e');
    }
  }

  void _showNotification() async {
    final isNowWork = _isWorkSession.value;

    final title = 'Pomodoro App';
    final body =
        isNowWork
            ? '☕ Break over! Let’s get back to work.'
            : '⏰ Work session complete! Time to take a break.';

    final androidDetails = AndroidNotificationDetails(
      'pomodoro_channel',
      'Pomodoro Notifications',
      channelDescription: 'Notifications for Pomodoro timer',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    final iosDetails = DarwinNotificationDetails(
      sound: 'default',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final notificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
  }

  @override
  void onClose() {
    _timer?.cancel();
    player.dispose();
    super.onClose();
  }
}
