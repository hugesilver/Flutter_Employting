import 'package:get/get.dart';

class SigninController extends GetxController {
  RxBool isLoading = false.obs;
  RxString emailText = "".obs;
  RxString passwordText = "".obs;

  void changeEmail(value) {
    emailText.value = value;
  }

  void changePassword(value) {
    passwordText.value = value;
  }
}
