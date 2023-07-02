import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:get/get.dart';

import 'controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final SignupController controller = Get.put(SignupController());

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
            width: 2.w,
            color: etDarkGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: 2.w,
            color: etDarkGrey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: 2.w,
            color: etBlack,
          ),
        ),
      );

  final List<String> _deptList = [
    '기계과',
    '건축과',
    '경영과',
    '도서미디어정보과',
    '미래자동차학부',
    '반도체과',
    '방송음향영상학부',
    '보건안전과',
    '보건의료기기과',
    '보건의료행정과',
    '사무행정과',
    '사회복지과',
    '소방안전설비과',
    '스마트팩토리과',
    '스포츠지도과',
    '실내디자인학부',
    '언어치료과',
    '유아교육보육학부',
    '전기과',
    '전자통신과',
    '컴퓨터정보학부',
    '토목환경과',
    '항공서비스과',
    '해군기술부사관과',
    '호텔레저과',
    '호텔조리제과학부',
  ];

  @override
  Widget build(BuildContext context) {
    void firebaseRegister() async {
      controller.isLoading.value = true;
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('nickName', isEqualTo: controller.nickNameText.value)
            .get();
        if (snapshot.docs.isNotEmpty) {
          controller.isLoading.value = false;
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('오류'),
                content: const Text('중복된 닉네임입니다.'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('확인'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            },
          );
          return;
        } else {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: '${controller.emailText.value}@email.daelim.ac.kr',
                  password: controller.passwordText.value)
              .then((value) async {
            try {
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(value.user!.uid)
                  .set({
                'uid': value.user!.uid,
                'email': '${controller.emailText.value}@email.daelim.ac.kr',
                'nickName': controller.nickNameText.value,
                'number': controller.numberText.value,
                'dept': controller.deptText.value,
              });
              FirebaseAuth.instance.currentUser?.sendEmailVerification();
              controller.isLoading.value = false;
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('성공'),
                    content: const Text(
                        '회원가입에 성공하였습니다!\n이메일 확인 링크 클릭 후, 로그인을 해주세요.'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.pop(context);
                          Get.back();
                        },
                      )
                    ],
                  );
                },
              );
            } catch (e) {
              controller.isLoading.value = false;
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('오류'),
                    content: const Text('유저 데이터 생성 중 오류가 발생했습니다.'),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('확인'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            }
          });
        }
      } on FirebaseAuthException catch (e) {
        controller.isLoading.value = false;
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('오류'),
              content: Text('회원가입 중 오류가 발생했습니다.\n${e.code}'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
          ),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 71.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: etDarkGrey,
                        size: 22.0.h,
                      ),
                    ),
                    SizedBox(
                      height: 52.h,
                    ),
                    Text(
                      '회원가입',
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 32.sp,
                        fontWeight: bold,
                        color: etBlack,
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2.w, color: etDarkGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Obx(
                                () => TextField(
                                  enabled:
                                      controller.isLoading.value ? false : true,
                                  style: inputTextDeco(),
                                  decoration: null,
                                  cursorColor: etBlack,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-zA-Z0-9]')),
                                  ],
                                  onChanged: (value) {
                                    controller.changeEmail(value);
                                  },
                                ),
                              ),
                            ),
                            Text(
                              '@email.daelim.ac.kr',
                              style: inputTextDeco(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading.value ? false : true,
                          obscureText: true, // 비밀번호 가리기
                          style: inputTextDeco(),
                          decoration: inputDeco('비밀번호(6자 이상)'),
                          cursorColor: etBlack,
                          onChanged: (value) {
                            controller.changePassword(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading.value ? false : true,
                          obscureText: true, // 비밀번호 가리기
                          style: inputTextDeco(),
                          decoration: inputDeco('비밀번호 확인'),
                          cursorColor: etBlack,
                          onChanged: (value) {
                            controller.changePasswordConfirm(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading.value ? false : true,
                          style: inputTextDeco(),
                          decoration: inputDeco('닉네임(12자 이하)'),
                          cursorColor: etBlack,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[a-zA-Zㄱ-ㅎ가-힣0-923]+$')),
                          ],
                          onChanged: (value) {
                            controller.changeNickName(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 45.h,
                      child: Obx(
                        () => TextField(
                          enabled: controller.isLoading.value ? false : true,
                          style: inputTextDeco(),
                          decoration: inputDeco('학번/교번'),
                          cursorColor: etBlack,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(9),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            controller.changeNumber(value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isLoading.value == true
                            ? null
                            : () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (_) {
                                      return SizedBox(
                                        height: 300.h,
                                        child: CupertinoPicker(
                                          backgroundColor: Colors.white,
                                          onSelectedItemChanged: (index) {
                                            controller
                                                .changeDept(_deptList[index]);
                                          },
                                          itemExtent: 40.h,
                                          children: _deptList.map((value) {
                                            return Center(child: Text(value));
                                          }).toList(),
                                        ),
                                      );
                                    });
                              },
                        child: Container(
                          height: 45.h,
                          decoration: BoxDecoration(
                            border: Border.all(width: 2.w, color: etDarkGrey),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  controller.deptText.value == ""
                                      ? "학과"
                                      : controller.deptText.value,
                                  style: inputTextDeco(),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_sharp,
                                  size: 30.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Obx(
                      () => GestureDetector(
                        onTap: controller.isLoading.value == true
                            ? null
                            : () {
                                if (controller.emailText.value != "" &&
                                    controller.passwordText.value.length >= 4 &&
                                    (controller.passwordText.value ==
                                        controller.passwordConfirmText.value) &&
                                    controller.nickNameText.value.length >= 2 &&
                                    (controller.numberText.value.length == 7 ||
                                        controller.numberText.value.length ==
                                            9) &&
                                    controller.deptText.value != "") {
                                  if (controller.numberText.value.length == 7) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('알림'),
                                          content: Text(
                                              '${controller.numberText.value}\n위 교번으로 가입하실 경우, 구분이 "교수"로 지정됩니다. 계속 하시겠습니까?'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('취소'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: const Text('확인'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                firebaseRegister();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else if (controller
                                          .numberText.value.length ==
                                      9) {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: const Text('알림'),
                                          content: Text(
                                              '${controller.numberText.value}\n위 학번이 맞으십니까?'),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text('취소'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: const Text('확인'),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                firebaseRegister();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.isLoading.value == true ||
                                    !(controller.emailText.value != "" &&
                                        controller.passwordText.value.length >=
                                            4 &&
                                        (controller.passwordText.value ==
                                            controller
                                                .passwordConfirmText.value) &&
                                        controller.nickNameText.value.length >=
                                            2 &&
                                        (controller.numberText.value.length ==
                                                7 ||
                                            controller
                                                    .numberText.value.length ==
                                                9) &&
                                        controller.deptText.value != "")
                                ? etLightGrey
                                : etBlue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.r),
                            ),
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.04929,
                          child: Center(
                            child: Text(
                              '계정 등록하기',
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
                    bottomPadding,
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
