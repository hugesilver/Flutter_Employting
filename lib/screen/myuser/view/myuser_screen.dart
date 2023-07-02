import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutting/constant/colors.dart';
import 'package:flutting/constant/fonts.dart';
import 'package:flutting/constant/named_widget.dart';
import 'package:flutting/main.dart';
import 'package:flutting/root_tab/view/root_tab_view.dart';
import 'package:flutting/screen/myuser/controller/myuser_controller.dart';
import 'package:flutting/screen/myuser/layout/text_container_layout.dart';
import 'package:get/get.dart';

class MyUserScreen extends GetView<MyUserController> {
  MyUserScreen({Key? key}) : super(key: key);

  @override
  final MyUserController controller = Get.put(MyUserController());

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
            color: etDarkGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(
            width: 1.w,
            color: etDarkGrey,
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
    void updateUserData() async {
      controller.isLoading.value = true;
      try {
        DocumentSnapshot myData =
            await FirebaseFirestore.instance.collection('user').doc(uid).get();
        if ((myData.data() as Map<String, dynamic>).containsKey('changed')) {
          controller.isLoading.value = false;
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text('오류'),
                content: const Text('이미 변경 이력이 있는 계정입니다.'),
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
            FirebaseFirestore.instance.collection('user').doc(uid).update({
              'nickName': controller.nickNameText.value,
              'dept': controller.deptText.value,
              'changed': true,
            });
            await const FlutterSecureStorage()
                .write(key: "nickName", value: controller.nickNameText.value);
            await const FlutterSecureStorage()
                .write(key: "dept", value: controller.deptText.value);

            nickName = await const FlutterSecureStorage().read(key: 'nickName');
            dept = await const FlutterSecureStorage().read(key: 'dept');
            controller.isLoading.value = false;
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: const Text('알림'),
                  content: const Text('변경이 완료되었습니다.'),
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
      } catch (e) {
        controller.isLoading.value = false;
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('오류'),
              content: const Text('변경 중 오류가 발생했습니다.'),
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
      }
    }

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            topPadding,
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 15,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 70,
                    child: Text(
                      '내 정보',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 28.sp,
                        fontWeight: bold,
                        color: etBlack,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: const Text('알림'),
                                content: const Text(
                                    '내 정보 변경은 한 번밖에 변경이 불가능합니다.\n계속 하시겠습니까?'),
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
                                      updateUserData();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "저장",
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 18.sp,
                              fontWeight: medium,
                              color: etBlue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.5.h,
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
                  Text(
                    "닉네임",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: medium,
                      color: etBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      style: inputTextDeco(),
                      decoration: inputDeco('닉네임'),
                      cursorColor: etBlack,
                      onChanged: (value) {
                        controller.changeNickName(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "이메일",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: medium,
                      color: etBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextContainerLayout(
                    child: Text(
                      email!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: medium,
                        color: etBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "학번",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: medium,
                      color: etBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextContainerLayout(
                    child: Text(
                      number!,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: medium,
                        color: etBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '구분',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: medium,
                      color: etBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextContainerLayout(
                    child: Text(
                      number!.length == 7
                          ? '교수'
                          : number!.length == 9
                              ? '학생'
                              : '기타',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: medium,
                        color: etBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '학과',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: medium,
                      color: etBlack,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  GestureDetector(
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
                                        controller.changeDept(_deptList[index]);
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
                      height: 40.h,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: etDarkGrey),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                controller.deptText.value == ""
                                    ? dept!
                                    : controller.deptText.value,
                                style: inputTextDeco(),
                              ),
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
                  SizedBox(
                    height: 30.h,
                  ),
                  divider,
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () async {
                      await const FlutterSecureStorage().deleteAll();
                      await FirebaseAuth.instance.signOut();
                      Get.to(() => const RootTab());
                    },
                    child: Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: etLightGrey,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
