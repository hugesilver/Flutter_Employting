import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/pdf/controller/pdf_controller.dart';
import 'package:get/get.dart';

class PDFScreen extends StatelessWidget {
  PDFScreen({super.key, required this.pdfPath});
  final String pdfPath;

  final PdfController controller = Get.put(PdfController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    child: Obx(
                      () => Text(
                        '${controller.page.value} / ${controller.total.value}',
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
              child: PDF(
                swipeHorizontal: true,
                onPageChanged: (page, total) {
                  controller.changePage(page);
                  controller.changeTotal(total);
                },
              ).cachedFromUrl(
                pdfPath,
                placeholder: (progress) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CupertinoActivityIndicator(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '$progress %',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 13.sp,
                          fontWeight: medium,
                          color: etDarkGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
