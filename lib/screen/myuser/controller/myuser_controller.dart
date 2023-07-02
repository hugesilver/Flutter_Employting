import 'package:get/get.dart';

class MyUserController extends GetxController {
  RxBool isLoading = false.obs;
  RxString nickNameText = "".obs;
  RxString deptText = "".obs;

  void changeNickName(value) {
    nickNameText.value = value;
  }

  void changeDept(value) {
    deptText.value = value;
  }
}
