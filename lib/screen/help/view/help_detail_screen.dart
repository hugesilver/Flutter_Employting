import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/pdf/pdf_screen.dart';
import 'package:get/get.dart';

class HelpDetailScreen extends StatelessWidget {
  const HelpDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments[0];
    final String content = Get.arguments[1];
    final String nickName = Get.arguments[2];
    final String dept = Get.arguments[3];
    final String pdf = Get.arguments[4];
    final String formatDate = Get.arguments[5];

    print(pdf.toString());
    return Scaffold(
      body: SafeArea(
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
                              Icons.arrow_back_ios,
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
                      title,
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
              height: 27.5.h,
            ),
            divider,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32.5.h,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 21.sp,
                          fontWeight: bold,
                          color: etBlack,
                        ),
                      ),
                      pdf == ""
                          ? const SizedBox()
                          : SizedBox(
                              height: 25.h,
                            ),
                      pdf == ""
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                Get.to(() => PDFScreen(pdfPath: pdf));
                              },
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
                                        '자기소개서 PDF 확인',
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
                        height: 15.h,
                      ),
                      Text(
                        content,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 16.sp,
                          fontWeight: medium,
                          color: etBlack,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '$dept · $nickName',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18.sp,
                          fontWeight: medium,
                          color: etGrey,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        formatDate,
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13.sp,
                          fontWeight: medium,
                          color: etGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
