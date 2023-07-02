import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          const CircularProgressIndicator();
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://job.daelim.ac.kr/index.do'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (await controller.canGoBack()) {
                        controller.goBack();
                      }
                    },
                    child: Icon(Icons.arrow_back_ios, size: 28.h),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.reload();
                    },
                    child: Icon(Icons.refresh, size: 32.h),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.loadRequest(
                          Uri.parse('https://job.daelim.ac.kr/index.do'));
                    },
                    child: Icon(Icons.home, size: 32.h),
                  ),
                ],
              ),
            ),
            Expanded(
                child: WebViewWidget(
              controller: controller,
            ))
          ],
        ),
      ),
    );
  }
}
