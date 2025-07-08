import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_app/constants/app_styles.dart';
import 'package:pomodoro_app/constants/common_widgets.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_padding.dart';
import '../../../constants/app_strings.dart';
import '../controllers/time_controller.dart';

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
