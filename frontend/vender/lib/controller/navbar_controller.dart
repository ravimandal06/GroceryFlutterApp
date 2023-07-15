import 'package:get/get.dart';

class Navabar_controller extends GetxController {
  RxInt index = 0.obs;

  void update_index(int selectedIndex) {
    index.value = selectedIndex;

    update();
  }
}
