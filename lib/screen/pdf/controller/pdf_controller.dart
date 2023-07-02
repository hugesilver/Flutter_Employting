import 'package:get/get.dart';

class PdfController extends GetxController {
  RxInt page = 0.obs;
  RxInt total = 0.obs;

  void changePage(value) {
    page.value = value;
  }

  void changeTotal(value) {
    total.value = value;
  }
}
