import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutting/screen/help/model/help_model.dart';
import 'package:get/get.dart';

class HelpController extends GetxController {
  static HelpController get to => Get.find();
  RxList<HelpModel> helpList = <HelpModel>[].obs;
  RxInt helpDataCount = 0.obs;
  DateTime? formatDate = DateTime.now();
  String? customDate = "";

  Stream<List<HelpModel>> helpStreamDataGet() {
    return FirebaseFirestore.instance
        .collection('help')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => HelpModel.fromJson(doc.data()))
          .toList();
    });
  }

}
