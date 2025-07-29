import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/constants/app_strings.dart';
import 'package:pomodoro_app/modules/pomodoro/bindings/time_binding.dart';
import 'package:pomodoro_app/modules/pomodoro/views/pomodoro_view.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AndroidInitializationSettings androidInitializationSettings = const AndroidInitializationSettings(
    '@mipmap/ic_launcher',
  );

  DarwinInitializationSettings darwinInitializationSettings = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    requestCriticalPermission: true,
  );

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidInitializationSettings,
    iOS: darwinInitializationSettings,
  );

  bool? initialized = await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  log('~~~>Flutter Local Notifications Plugin initialized: $initialized');
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
