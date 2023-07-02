import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/help/controller/help_upload_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HelpUploadScreen extends StatelessWidget {
  const HelpUploadScreen({super.key});

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
    final HelpUploadController helpUploadController =
        Get.put(HelpUploadController());
    return Scaffold(
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
                        '질문 작성',
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
                            onTap: helpUploadController
                                        .helpTitleText.isNotEmpty &&
                                    helpUploadController
                                        .helpContentText.isNotEmpty &&
                                    helpUploadController.helpIsLoading == false
                                ? () {
                                    final now = DateTime.now();
                                    helpUploadController.uploadPost(
                                      DateFormat('yyyyMMddHHmmss').format(now),
                                      now,
                                    );
                                    Get.back();
                                  }
                                : () {},
                            child: Text(
                              "완료",
                              style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18.sp,
                                fontWeight: medium,
                                color: helpUploadController
                                            .helpTitleText.isNotEmpty &&
                                        helpUploadController
                                            .helpContentText.isNotEmpty &&
                                        helpUploadController.helpIsLoading ==
                                            false
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
                        onChanged: (value) =>
                            helpUploadController.homeChangeTitle(value),
                        style: inputTextDeco(),
                        decoration: inputDeco('글 제목'),
                        cursorColor: etBlack,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 280.h,
                      child: TextField(
                        onChanged: (value) =>
                            helpUploadController.homeChangeContent(value),
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        style: inputTextDeco(),
                        decoration: inputDeco('설명글'),
                        cursorColor: etBlack,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      '자기소개서 파일',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18.sp,
                        fontWeight: medium,
                        color: etBlack,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () => helpUploadController.uploadPDF(),
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
                    Obx(() => Text(helpUploadController.helpPickText.value)),
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
