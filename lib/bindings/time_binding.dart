import 'package:get/get.dart';
import 'package:pomodoro_app/bindings/time_controller.dart';
 
class TimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeController>(() => TimeController());
  }
}
