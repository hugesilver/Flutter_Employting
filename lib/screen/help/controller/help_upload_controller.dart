import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutting/main.dart';
import 'package:get/get.dart';

class HelpUploadController extends GetxController {
  static HelpUploadController get to => Get.find();
  RxBool helpIsLoading = false.obs;
  RxString helpTitleText = "".obs;
  RxString helpContentText = "".obs;
  RxString helpPickText = "".obs;
  File? file;
  Uint8List? fileBytes;

  void homeChangeTitle(value) {
    helpTitleText.value = value;
  }

  void homeChangeContent(value) {
    helpContentText.value = value;
  }

  Future<void> uploadPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      file = File(result.files.single.path!);
      helpPickText.value = result.files.single.name;
      fileBytes = await file?.readAsBytes();
    } else {
      Get.back();
    }
  }

  void uploadPost(String id, DateTime dateTime) async {
    print('upload start');
    helpIsLoading = true.obs;
    String downloadURL = "";
    try {
      if (file != null) {
        Reference storageRef =
            FirebaseStorage.instance.ref().child('help/${dateTime}_uid');
        UploadTask uploadTask = storageRef.putData(fileBytes!);
        TaskSnapshot taskSnapshot = await uploadTask;
        downloadURL = await taskSnapshot.ref.getDownloadURL();
        print(downloadURL);
      }

      await FirebaseFirestore.instance.collection('help').doc(id).set({
        'uid': uid,
        'nickName': nickName,
        'pdf': downloadURL,
        'title': helpTitleText.value,
        'dateTime': dateTime,
        'content': helpContentText.value,
        'dept': dept,
      });
      helpIsLoading = false.obs;
      helpTitleText = "".obs;
      helpContentText = "".obs;

      Get.back();
    } catch (e) {
      print(e.toString());
      helpIsLoading = false.obs;
    }
  }
}
