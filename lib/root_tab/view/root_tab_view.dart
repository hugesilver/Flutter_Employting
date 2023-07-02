import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutting/screen/webview/view/webview_screen.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/fonts.dart';
import '../../screen/event/event_screen.dart';
import '../../screen/help/view/help_screen.dart';
import '../../screen/home/view/home_screen.dart';
import '../../screen/myuser/view/myuser_screen.dart';
import '../controller/root_tab_controller.dart';

class RootTab extends GetView<RootTabController> {
  const RootTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RootTabController());
    final List<String> list = List.generate(10, (index) => 'Text $index');
    return Obx(
      () => Scaffold(
        body: homeIndex(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: etGrey, width: 1.w),
            ),
          ),
          child: homeBottom(),
        ),
      ),
    );
  }

  Widget homeIndex() {
    return IndexedStack(
      index: controller.pageIndex.value,
      children: [
        const HomeScreen(),
        const WebViewScreen(),
        const HelpScreen(),
        EventScreen(),
        MyUserScreen(),
      ],
    );
  }

  Widget bottomNaviIcon(String icon, String label) {
    return Column(
      children: [
        Image.asset('assets/images/navigation/$icon.png',
            width: 25.w, height: 25.h),
        SizedBox(height: 5.h),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 10.sp,
            fontWeight: bold,
            color: etDarkGrey,
          ),
        ),
      ],
    );
  }

  Widget homeBottom() {
    List<BottomNavigationBarItem> bottomItems = [
      BottomNavigationBarItem(
        icon: bottomNaviIcon('home', '채용공고'),
        activeIcon: bottomNaviIcon('fill_home', '채용공고'),
        label: '',
      ),
      BottomNavigationBarItem(
          icon: bottomNaviIcon('compass', '취업게시판'),
          activeIcon: bottomNaviIcon('fill_compass', '취업게시판'),
          label: ''),
      BottomNavigationBarItem(
          icon: bottomNaviIcon('help', '질문게시판'),
          activeIcon: bottomNaviIcon('fill_help', '질문게시판'),
          label: ''),
      BottomNavigationBarItem(
          icon: bottomNaviIcon('event', '행사게시판'),
          activeIcon: bottomNaviIcon('fill_event', '행사게시판'),
          label: ''),
      BottomNavigationBarItem(
          icon: bottomNaviIcon('mypage', '내 정보'),
          activeIcon: bottomNaviIcon('fill_mypage', '내 정보'),
          label: ''),
    ];
    return BottomNavigationBar(
      onTap: controller.changePageIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: etWhite,
      elevation: 0,
      currentIndex: controller.pageIndex.value,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: bottomItems,
    );
  }
}
