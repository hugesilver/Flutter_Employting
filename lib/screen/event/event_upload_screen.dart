import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/event/controller/event_upload_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventUploadScreen extends StatelessWidget {
  EventUploadScreen({Key? key}) : super(key: key);

  final EventUploadController controller = Get.put(EventUploadController());

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
                        '행사 등록',
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
                      height: 32.5.h,
                    ),
                    Text(
                      '사진',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18.sp,
                        fontWeight: medium,
                        color: etBlack,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(() {
                      if (controller.imagePath.isEmpty) {
                        return GestureDetector(
                          onTap: () {
                            controller.selectImage();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 96.w,
                                height: 96.w,
                                color: etGrey,
                              ),
                              const Icon(
                                Icons.add,
                                size: 60,
                                color: etWhite,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Stack(
                          clipBehavior: Clip.none, // 부모 위젯을 벗어나도 잘리지 않게
                          children: [
                            Container(
                              width: 96.w,
                              height: 96.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: Image.file(
                                          File(controller.imagePath.value))
                                      .image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Obx(
                              () => controller.isLoading == true
                                  ? const SizedBox()
                                  : Positioned(
                                      top: 5.h,
                                      right: 5.w,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.removeImage();
                                        },
                                        child: Container(
                                          width: 20.w,
                                          height: 20.h,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: etWhite,
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.remove,
                                              size: 15.w,
                                              color: etBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        );
                      }
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    divider,
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 40.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading == true ? false : true,
                          style: inputTextDeco(),
                          decoration: inputDeco('글 제목'),
                          cursorColor: etBlack,
                          onChanged: (value) {
                            controller.changeTitle(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 280.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading == true ? false : true,
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
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
