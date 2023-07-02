import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutting/screen/event/model/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get to => Get.find();
  RxList<EventModel> eventList = <EventModel>[].obs;
  RxInt eventDataCount = 0.obs;
  Rx<DateTime> formatDate = DateTime.now().obs;
  String? customDate = "";

  Stream<List<EventModel>> eventDataGet() async* {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection("event").get();

    eventList.clear(); // 기존 데이터를 모두 제거

    for (var element in querySnapshot.docs) {
      eventList.add(EventModel.fromJson(element.data()));
    }
    eventList.value = eventList.reversed.toList();

    eventDataCount.value = eventList.length; // 길이를 업데이트
    print(eventDataCount.value);

    yield eventList;
  }
}
