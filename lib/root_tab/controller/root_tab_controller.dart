import 'package:get/get.dart';

class RootTabController extends GetxController{
  RxInt pageIndex = 0.obs;
  void changePageIndex (int index) {
    pageIndex(index);
  }
}
