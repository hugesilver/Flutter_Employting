import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/help/controller/help_controller.dart';
import 'package:flutting/screen/help/model/help_model.dart';
import 'package:flutting/screen/help/view/help_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'help_upload_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HelpController helpController = Get.put(HelpController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'helpFAB',
        onPressed: () {
          Get.to(() => const HelpUploadScreen());
        },
        child: Icon(
          Icons.add,
          size: 30.h,
          color: etWhite,
        ),
      ),
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
                      '질문게시판',
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
                child: StreamBuilder<List<HelpModel>>(
                    initialData: helpController.helpList,
                    stream: helpController.helpStreamDataGet(),
                    builder: (context, snapshot) {
                      print(helpController.helpDataCount);
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        separatorBuilder: (context, index) => divider,
                        itemBuilder: (context, index) {
                          final formatDate = DateFormat(
                                  'yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                              .format(snapshot.data![index].dateTime!.toDate());
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(top: 35.5.h, bottom: 10.h)
                                : EdgeInsets.symmetric(vertical: 10.h),
                            child: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.to(() => const HelpDetailScreen(),
                                    arguments: [
                                      snapshot.data![index].title,
                                      snapshot.data![index].content,
                                      snapshot.data![index].nickName,
                                      snapshot.data![index].dept,
                                      snapshot.data![index].pdf,
                                      formatDate,
                                    ]);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data![index].title!,
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
                                    '${snapshot.data![index].dept} · ${snapshot.data![index].nickName}',
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
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
