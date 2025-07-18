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

  void showInputDialog() {
    int workMinutes = 25;
    int breakMinutes = 5;
    final controller = Get.find<TimeController>();

    Get.defaultDialog(
      title: AppString.setDurations,
      content: Column(
        children: [
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: AppString.workDurationInMinutes),
            onChanged: (value) => workMinutes = int.tryParse(value) ?? 25,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: AppString.breakDurationInMinutes),
            onChanged: (value) => breakMinutes = int.tryParse(value) ?? 5,
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          controller.setDurations(workMinutes, breakMinutes);
          Get.back();
        },
        child: const Text(AppString.save),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PomodoroAppBar(onSettingsPressed: showInputDialog),
      body: const PomodoroBody(),
    );
  }
}

class PomodoroAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSettingsPressed;
  const PomodoroAppBar({required this.onSettingsPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        AppString.appTitle,
        style: TextStyle(color: AppColors.appBarText, fontWeight: FontWeight.w600),
      ),
      backgroundColor: AppColors.primary,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.appBarText),
          onPressed: onSettingsPressed,
          tooltip: AppString.settingsTooltip,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PomodoroBody extends StatelessWidget {
  const PomodoroBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeController>();
    return Center(
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
          const PomodoroControlButtons(),
        ],
      ),
    );
  }
}

class PomodoroControlButtons extends StatelessWidget {
  const PomodoroControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TimeController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => AppButton(
            label: controller.isRunning ? AppString.pauseTimer : AppString.startTimer,
            onPressed: controller.isRunning ? controller.pauseTimer : controller.startTimer,
          ),
        ),
        AppMargin.horizontal20,
        AppButton(label: AppString.resetTimer, onPressed: controller.resetTimer),
      ],
    );
  }
}
