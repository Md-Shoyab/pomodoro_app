import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/bindings/time_controller.dart';
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
            Obx(() => Text(controller.formattedTime, style: AppTextStyles.timerText)),
            AppMargin.vertical20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(label: AppString.startTimer, onPressed: controller.startTimer),
                AppMargin.horizontal20,
                AppButton(label: AppString.resetTimer, onPressed: controller.resetTimer),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(color: AppColors.buttonText)),
    );
  }
}

class AppTextStyles {
  static const timerText = TextStyle(fontSize: 48, fontWeight: FontWeight.w600);
}
