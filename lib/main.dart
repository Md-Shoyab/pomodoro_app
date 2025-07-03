import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Colors.red;
  static const Color appBarText = Colors.white;
  static const Color buttonText = Colors.white;
}

abstract class AppString {
  static const String appTitle = 'Pomodoro App';
  static const String workTime = 'Work Time';
  static const String runningTimer = '25:00';
  static const String startTimer = 'Start Timer';
  static const String resetTimer = 'Reset Timer';
  static const String settingsTooltip = 'Settings';
}

abstract class AppMargin {
  static const vertical20 = SizedBox(height: 20);
  static const horizontal20 = SizedBox(width: 20);
}

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
