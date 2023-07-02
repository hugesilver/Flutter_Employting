import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/main.dart';
import 'package:flutting/screen/event/controller/event_controller.dart';
import 'package:flutting/screen/event/event_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constant/colors.dart';
import '../../constant/fonts.dart';
import '../../constant/named_widget.dart';
import 'event_upload_screen.dart';
import 'model/event_model.dart';

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);

  final EventController _eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: number!.length == 7
          ? FloatingActionButton(
              heroTag: 'eventFAB',
              onPressed: () {
                Get.to(() => EventUploadScreen());
              },
              child: Icon(
                Icons.add,
                size: 30.h,
                color: etWhite,
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // 타이틀
            topPadding,
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 15,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 70,
                    child: Text(
                      '행사게시판',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 28.sp,
                        fontWeight: bold,
                        color: etBlack,
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 15,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.5.h,
            ),
            divider,

            // 리스트 뷰
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: StreamBuilder<List<EventModel>>(
                  stream: _eventController.eventDataGet(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.separated(
                        itemCount: _eventController.eventDataCount(),
                        separatorBuilder: (context, index) => divider,
                        itemBuilder: (context, index) {
                          final formatDate =
                              DateFormat('yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                                  .format(_eventController
                                      .eventList[index].dateTime!
                                      .toDate());
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(top: 35.5.h, bottom: 10.h)
                                : EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.to(() => const EventDetailScreen(),
                                    arguments: [
                                      _eventController.eventList[index].title,
                                      _eventController.eventList[index].content,
                                      _eventController
                                          .eventList[index].nickName,
                                      _eventController.eventList[index].dept,
                                      _eventController.eventList[index].image,
                                      formatDate,
                                    ]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _eventController.eventList[index].title!,
                                    overflow: TextOverflow
                                        .ellipsis, // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 21.sp,
                                      fontWeight: medium,
                                      color: etBlack,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    '${_eventController.eventList[index].dept} · ${_eventController.eventList[index].nickName}',
                                    overflow: TextOverflow
                                        .ellipsis, // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      color: etGrey,
                                    ),
                                  ),
                                  Text(
                                    formatDate,
                                    overflow: TextOverflow
                                        .ellipsis, // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Pretendard',
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      color: etGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          '등록된 게시글이 없어요.',
                          style: TextStyle(
                            fontFamily: 'Pretendard',
                            fontSize: 14.sp,
                            fontWeight: bold,
                            color: etLightGrey,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
