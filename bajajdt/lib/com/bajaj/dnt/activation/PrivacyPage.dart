import 'dart:async';
import 'dart:io';

import 'package:bajajdt/com/bajaj/dnt/custom/CustomUIElements.dart';
import 'package:bajajdt/com/bajaj/dnt/utils/AppConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyRoute extends CupertinoPageRoute {
  PrivacyRoute() : super(builder: (BuildContext context) => new PrivacyPage());

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(
      opacity: animation,
      child: new PrivacyPage(),
    );
  }
}

class PrivacyPage extends StatefulWidget {
  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => _moveBack(),
        ),
        title: CustomUIElements.getText15('Privacy Policy'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: AppConstants.privacyPolicy,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
        );
      }),
    );
  }

  void _moveBack() {
    Navigator.pop(context, true);
  }
}
