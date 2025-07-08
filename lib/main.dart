import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/constants/app_strings.dart';
import 'package:pomodoro_app/modules/pomodoro/bindings/time_binding.dart';
import 'package:pomodoro_app/modules/pomodoro/views/pomodoro_view.dart';

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



