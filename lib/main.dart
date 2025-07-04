import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/app_colors.dart';
import 'package:pomodoro_app/constants/app_padding.dart';
import 'package:pomodoro_app/constants/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appTitle,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
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
            const Text(
              AppString.runningTimer,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.w600),
            ),
            AppMargin.vertical20,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  onPressed: () {
                    // Start timer logic
                  },
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
