import 'package:get/get.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxString emailText = "".obs;
  RxString passwordText = "".obs;
  RxString passwordConfirmText = "".obs;
  RxString nickNameText = "".obs;
  RxString numberText = "".obs;
  RxString deptText = "".obs;

  void changeEmail(value) {
    emailText.value = value;
  }

  void changePassword(value) {
    passwordText.value = value;
  }

  void changePasswordConfirm(value) {
    passwordConfirmText.value = value;
  }

  void changeNickName(value) {
    nickNameText.value = value;
  }

  void changeNumber(value) {
    numberText.value = value;
  }

  void changeDept(value) {
    deptText.value = value;
  }
}
