import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/main.dart';
import 'package:flutting/root_tab/view/root_tab_view.dart';
import 'package:flutting/screen/signin/controller/signin_controller.dart';
import 'package:get/get.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final SigninController controller = Get.put(SigninController());

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

  @override
  Widget build(BuildContext context) {
    void firebaseLogin() async {
      controller.isLoading.value = true;
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: '${controller.emailText.value}@email.daelim.ac.kr',
                password: controller.passwordText.value)
            .then((value) async {
          // if (value.user!.emailVerified == true) {
          await const FlutterSecureStorage().deleteAll();

          DocumentSnapshot<Map<String, dynamic>> userData =
              await FirebaseFirestore.instance
                  .collection('user')
                  .doc(value.user!.uid)
                  .get();
          await const FlutterSecureStorage()
              .write(key: "uid", value: value.user!.uid);
          await const FlutterSecureStorage()
              .write(key: "email", value: '${userData.data()?['email']}');
          await const FlutterSecureStorage()
              .write(key: "nickName", value: '${userData.data()?['nickName']}');
          await const FlutterSecureStorage()
              .write(key: "number", value: '${userData.data()?['number']}');
          await const FlutterSecureStorage()
              .write(key: "dept", value: '${userData.data()?['dept']}');

          uid = await const FlutterSecureStorage().read(key: 'uid');
          email = await const FlutterSecureStorage().read(key: 'email');
          nickName = await const FlutterSecureStorage().read(key: 'nickName');
          number = await const FlutterSecureStorage().read(key: 'number');
          dept = await const FlutterSecureStorage().read(key: 'dept');

          controller.isLoading.value = false;
          Get.to(() => const RootTab());
          // } else {
          //   controller.isLoading.value = false;
          //   showCupertinoDialog(
          //     context: context,
          //     builder: (context) {
          //       return CupertinoAlertDialog(
          //         title: const Text('오류'),
          //         content: const Text(
          //             '인증받지 않은 계정입니다.\n메일함을 확인하여 인증 링크를 눌러주세요.\n(스팸메일함도 확인해주세요.)'),
          //         actions: [
          //           CupertinoDialogAction(
          //             child: const Text('확인'),
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //           )
          //         ],
          //       );
          //     },
          //   );
          //   return;
          // }
        });
      } on FirebaseAuthException catch (e) {
        controller.isLoading.value = false;
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('오류'),
              content: Text('로그인에 실패하였습니다..\n${e.code}'),
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
                      '로그인',
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
                                  cursorColor: etBlack,
                                  decoration: null,
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
                                    controller.passwordText.value != "") {
                                  firebaseLogin();
                                }
                              },
                        child: Container(
                          decoration: BoxDecoration(
                            color: controller.isLoading.value == true ||
                                    !(controller.emailText.value != "" &&
                                        controller.passwordText.value != "")
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
                              '로그인하기',
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
