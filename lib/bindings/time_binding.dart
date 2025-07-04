import 'package:get/get.dart';
import 'package:pomodoro_app/main.dart';

class TimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeController>(() => TimeController());
  }
}
