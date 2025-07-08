import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/app_colors.dart';

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