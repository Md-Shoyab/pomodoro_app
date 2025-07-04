import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/constants/app_colors.dart';
import 'package:pomodoro_app/constants/app_padding.dart';
import 'package:pomodoro_app/constants/app_strings.dart';
import 'package:pomodoro_app/bindings/time_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      initialBinding: TimeBinding(),
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends GetView<TimeController> {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppString.appTitle,
          style: TextStyle(color: AppColors.appBarText, fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.appBarText),
            onPressed: () {
              // Open drawer or menu
            },
            tooltip: AppString.settingsTooltip,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              AppString.workTime,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            AppMargin.vertical20,
            Obx(
              () => Text(
                '${controller.time.value.toString().padLeft(2, '0')}:${(controller.time.value % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
              ),
            ),
            AppMargin.vertical20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: controller.startTimer,
                  child: const Text(
                    AppString.startTimer,
                    style: TextStyle(color: AppColors.buttonText),
                  ),
                ),
                AppMargin.horizontal20,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () {
                    // Start timer logic
                  },
                  child: const Text(
                    AppString.resetTimer,
                    style: TextStyle(color: AppColors.buttonText),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeController extends GetxController {
  var time = 1500.obs; // 25 minutes in seconds
  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time.value > 0) {
        time.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    time.value = 1500; // Reset to 25 minutes
  }
}
