import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/screen/signup/signup_screen.dart';
import 'package:get/get.dart';

import 'signin/signin_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              const Expanded(
                flex: 15,
                child: SizedBox(),
              ),
              Expanded(
                flex: 70,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo/logo.png',
                    width: 183.w,
                    height: 183.w,
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpScreen());
                          },
                          child: Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.r,
                              ),
                              color: etBlue,
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                '회원가입',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 18.sp,
                                  fontWeight: bold,
                                  color: etWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => SigninScreen());
                          },
                          child: Container(
                            height: 38.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                5.r,
                              ),
                              color: etLightGrey,
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                '로그인',
                                style: TextStyle(
                                  fontFamily: 'Pretendard',
                                  fontSize: 18.sp,
                                  fontWeight: bold,
                                  color: etWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              bottomPadding,
            ],
          ),
        ),
      ),
    );
  }
}
