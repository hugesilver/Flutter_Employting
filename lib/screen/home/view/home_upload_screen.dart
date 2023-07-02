import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/screen/home/controller/home_upload_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constant/named_widget.dart';


class HomeUploadScreen extends StatelessWidget {
  HomeUploadScreen({super.key});

  final HomeUploadController controller = Get.put(HomeUploadController());

  TextStyle inputTextDeco() => TextStyle(
    fontFamily: 'Pretendard',
    fontSize: 18.sp,
    fontWeight: medium,
    color: etBlack,
  );

  InputDecoration inputDeco(String? hintText) => InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      fontFamily: 'Pretendard',
      fontSize: 18.sp,
      fontWeight: medium,
      color: etBlack,
    ),
    contentPadding: EdgeInsets.symmetric(
      vertical: 10.h,
      horizontal: 10.w,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        width: 1.w,
        color: etLightGrey,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        width: 1.w,
        color: etLightGrey,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        width: 1.w,
        color: etDarkGrey,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topPadding,
              window.viewPadding.top > 0
                  ? SizedBox(height: 7.h)
                  : SizedBox(height: 71.h),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 15,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SizedBox(
                            width: 30.w,
                            child: Padding(
                              padding: EdgeInsets.zero,
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: etDarkGrey,
                                size: 22.0.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 70,
                      child: Text(
                        '채용 공고 등록',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 22.sp,
                          fontWeight: medium,
                          color: etBlack,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 15,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Obx(
                              () => GestureDetector(
                            onTap: controller.titleText.isNotEmpty &&
                                controller.companyText.isNotEmpty &&
                                controller.contentText.isNotEmpty &&
                                controller.isLoading == false
                                ? () {
                              final now = DateTime.now();
                              controller.uploadPost(
                                DateFormat('yyyyMMddHHmmss').format(now),
                                now,
                              );
                            }
                                : () {},
                            child: Text(
                              "완료",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18.sp,
                                fontWeight: medium,
                                color: controller.titleText.isNotEmpty &&
                                    controller.companyText.isNotEmpty &&
                                    controller.contentText.isNotEmpty &&
                                    controller.isLoading == false
                                    ? etBlue
                                    : etLightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 27.5.h,
              ),
              divider,
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: TextField(
                        style: inputTextDeco(),
                        decoration: inputDeco('글 제목'),
                        cursorColor: etBlack,
                        onChanged: (value) {
                          controller.changeTitle(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: TextField(
                        style: inputTextDeco(),
                        decoration: inputDeco('기업명'),
                        cursorColor: etBlack,
                        onChanged: (value) {
                          controller.changeCompany(value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                minimumYear: DateTime.now().year,
                                maximumYear: 2099,
                                onDateTimeChanged: (DateTime newDate) {
                                  controller.changeEndDate(newDate);
                                });
                          },
                        );
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.w,
                            color: etLightGrey,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 10.w,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Obx(
                                  () => Text(
                                '마감일: ${DateFormat('yyyy. M. d', 'ko_KR').format(controller.endDate.value)}',
                                style: inputTextDeco(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 280.h,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        style: inputTextDeco(),
                        decoration: inputDeco('설명글'),
                        cursorColor: etBlack,
                        onChanged: (value) {
                          controller.changeContent(value);
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () => controller.homeUploadPDF(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: etLightGrey,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.w,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/icon/pdf_icon.png',
                                height: 18.h,
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                'PDF 파일 업로드',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 13.sp,
                                  fontWeight: medium,
                                  color: etWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Obx(() => Text(controller.homePickText.value)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}