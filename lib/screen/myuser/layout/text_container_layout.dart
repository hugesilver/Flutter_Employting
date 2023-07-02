import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';

class TextContainerLayout extends StatelessWidget {
  Widget? child;
  TextContainerLayout({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40.h,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.w,
          color: etDarkGrey,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        child: child,
      ),
    );
  }
}
