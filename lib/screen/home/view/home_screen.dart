import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/main.dart';
import 'package:flutting/screen/home/controller/home_controller.dart';
import 'package:flutting/screen/home/model/home_model.dart';
import 'package:flutting/screen/home/view/home_detail_screen.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constant/fonts.dart';
import 'home_upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    String query = "";
    return Obx(
      () => Scaffold(
        floatingActionButton: number!.length == 7
            ? FloatingActionButton(
                heroTag: 'homeFAB',
                onPressed: () {
                  Get.to(() => HomeUploadScreen());
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
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: homeController.homeSearchLoading.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              homeController.homeSearchLoading.value = false;
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 22.h,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: homeController.searchController,
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 22.sp,
                                fontWeight: medium,
                                color: etBlack,
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 22.sp,
                                  fontWeight: medium,
                                  color: etBlack,
                                ),
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              cursorHeight: 18.h,
                              cursorColor: etBlack,
                              onChanged: (value) {
                                homeController.homeChangeText(value);
                              },
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                homeController.homePageLoading.value = false,
                            child: Image.asset(
                              'assets/images/icon/search_icon.png',
                              width: 22.w,
                              height: 22.h,
                            ),
                          ),
                        ], // 아이콘 버튼 누르면 안바뀜
                      )
                    : Row(
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
                              '홈',
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
                          Expanded(
                            flex: 15,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => homeController
                                    .homeSearchLoading.value = true,
                                child: Image.asset(
                                  'assets/images/icon/search_icon.png',
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ),
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
              homeController.homePageLoading.value
                  ? StreamBuilder<List<HomeModel>>(
                      //false
                      stream: homeController.homeStreamDataGet(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: Text("오류입니다"));
                        } else if (snapshot.hasData) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              child: ListView.separated(
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, index) => divider,
                                itemBuilder: (context, index) {
                                  int remainingDuration =
                                      homeController.calculateDaysRemaining(
                                          snapshot.data![index].endDate!
                                              .toDate()); //마감일 계산
                                  final formatDate = DateFormat(
                                          'yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                                      .format(snapshot.data![index].dateTime!
                                          .toDate()); // 마감일
                                  final endFormatDate = DateFormat(
                                          'yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                                      .format(snapshot.data![index].endDate!
                                          .toDate()); //작성일
                                  return Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(
                                            top: 35.5.h, bottom: 10.h)
                                        : EdgeInsets.symmetric(vertical: 10.h),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Get.to(() => const HomeDetailScreen(),
                                            arguments: [
                                              snapshot.data![index].title,
                                              snapshot.data![index].content,
                                              snapshot.data![index].nickName,
                                              snapshot.data![index].dept,
                                              snapshot.data![index].uid,
                                              formatDate,
                                              endFormatDate,
                                            ]);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].title!,
                                            overflow: TextOverflow.ellipsis,
                                            // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: 'Pretendard',
                                              fontSize: 21.sp,
                                              fontWeight: medium,
                                              color: etBlack,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            remainingDuration <= 0
                                                ? '마감일이 지났습니다.'
                                                : '마감일이 $remainingDuration일 남았습니다.',
                                            overflow: TextOverflow.ellipsis,
                                            // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 16.sp,
                                                fontWeight: medium,
                                                color: remainingDuration <= 7
                                                    ? etRed
                                                    : etGreen),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${snapshot.data![index].dept} · ${snapshot.data![index].nickName}',
                                            overflow: TextOverflow.ellipsis,
                                            // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
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
                                            overflow: TextOverflow.ellipsis,
                                            // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
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
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      })
                  : FutureBuilder<List<HomeModel>>(
                      future: homeController.searchData(
                        homeController.homeSearchText.value,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print("error");
                        } else if (snapshot.hasData) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                              ),
                              child: ListView.separated(
                                itemCount: snapshot.data!.length,
                                separatorBuilder: (context, index) => divider,
                                itemBuilder: (context, index) {
                                  int remainingDuration =
                                      homeController.calculateDaysRemaining(
                                          snapshot.data![index].endDate!
                                              .toDate()); //마감일 계산
                                  final formatDate = DateFormat(
                                          'yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                                      .format(snapshot.data![index].dateTime!
                                          .toDate()); // 마감일
                                  final endFormatDate = DateFormat(
                                          'yyyy년 M월 d일 a h시 mm분', 'ko_KR')
                                      .format(snapshot.data![index].endDate!
                                          .toDate()); //작성일
                                  return Padding(
                                    padding: index == 0
                                        ? EdgeInsets.only(
                                            top: 35.5.h, bottom: 10.h)
                                        : EdgeInsets.symmetric(vertical: 10.h),
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        Get.to(() => const HomeDetailScreen(),
                                            arguments: [
                                              snapshot.data![index].title,
                                              snapshot.data![index].content,
                                              snapshot.data![index].nickName,
                                              snapshot.data![index].dept,
                                              snapshot.data![index].uid,
                                              formatDate,
                                              endFormatDate,
                                            ]);
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                            height: 5.h,
                                          ),
                                          Text(
                                            remainingDuration <= 0
                                                ? '마감일이 지났습니다.'
                                                : '마감일이 $remainingDuration일 남았습니다.',
                                            overflow: TextOverflow
                                                .ellipsis, // Text가 overflow 현상이 일어나면 뒷부분을 ...으로 생략한다
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: 'Pretendard',
                                                fontSize: 16.sp,
                                                fontWeight: medium,
                                                color: remainingDuration <= 7
                                                    ? etRed
                                                    : etGreen),
                                          ),
                                          SizedBox(
                                            height: 5.h,
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
                              ),
                            ),
                          );
                        }
                        return const CircularProgressIndicator();
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
