

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutting/main.dart';
import 'package:get/get.dart';

class HomeUploadController extends GetxController {
  RxBool isLoading = false.obs;
  RxString titleText = "".obs;
  Rx<DateTime> endDate = DateTime(2099, 12, 31).obs;
  RxString companyText = "".obs;
  RxString contentText = "".obs;
  RxString homePickText = "".obs;
  File? file;
  Uint8List? fileBytes;

  void changeTitle(value) {
    titleText.value = value;
  }

  void changeEndDate(value) {
    endDate.value = value;
  }

  void changeCompany(value) {
    companyText.value = value;
  }

  void changeContent(value) {
    contentText.value = value;
  }
  Future<void> homeUploadPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      file = File(result.files.single.path!);
      homePickText.value = result.files.single.name;
      fileBytes = await file?.readAsBytes();
    } else {
      Get.back();
    }
  }

  void uploadPost(String id, DateTime dateTime) async {
    print('upload start');
    isLoading = true.obs;
    if (file != null) {
      Reference storageRef =
      FirebaseStorage.instance.ref().child('home/${dateTime}_uid');
      UploadTask uploadTask = storageRef.putData(fileBytes!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
    }

    try {
      await FirebaseFirestore.instance
          .collection('home')
          .doc('${id}_$number')
          .set({
        'uid': uid,
        'id': '${id}_$number',
        'number': number,
        'nickName': nickName,
        'title': titleText.value,
        'content': contentText.value,
        'company': companyText.value,
        'dateTime': dateTime,
        'endDate': endDate.value,
        'dept': dept,
      });
      isLoading = false.obs;
      titleText = "".obs;
      contentText = "".obs;
      companyText = "".obs;
      endDate = DateTime(2099, 12, 31).obs;

      Get.back();
    } catch (e) {
      print(e.toString());
      isLoading = false.obs;
    }
  }
}
