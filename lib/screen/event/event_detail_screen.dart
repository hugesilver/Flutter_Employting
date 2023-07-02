import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/fonts.dart';
import '../../constant/named_widget.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = Get.arguments[0];
    final String content = Get.arguments[1];
    final String nickName = Get.arguments[2];
    final String dept = Get.arguments[3];
    final String? image = Get.arguments[4];
    final String formatDate = Get.arguments[5];
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    image == null
                        ? const SizedBox()
                        : CachedNetworkImage(
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            imageUrl: image,
                            placeholder: (context, url) =>
                                const CupertinoActivityIndicator(),
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                    Padding(
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
                          SizedBox(
                            height: 20.h,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
