import 'package:get/get.dart';

class DeviceController extends GetxController {
  var toggleStates = <String, RxBool>{}.obs;

  void initToggle(String docId, bool initial) {
    if (!toggleStates.containsKey(docId)) {
      toggleStates[docId] = RxBool(initial);
    }
  }

  void toggleDevice(String docId) {
    if (toggleStates.containsKey(docId)) {
      toggleStates[docId]!.value = !toggleStates[docId]!.value;
    }
  }

  bool getToggle(String docId) {
    return toggleStates[docId]?.value ?? false;
  }
}
