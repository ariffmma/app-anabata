import 'package:blogapp/Blog/Blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  InAppWebViewController _webViewController;
  String url = "";
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //fullscreen
        resizeToAvoidBottomPadding: false,
        body: Container(
            child: Column(children: <Widget>[
          //scroll
          SingleChildScrollView(
            child: Container(
                child: progress < 1.0
                    ? LinearProgressIndicator(
                        backgroundColor: Color(0xFFB4B4B4),
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                        value: progress)
                    : Container()),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: InAppWebView(
                initialUrl:
                    "https://app.sandbox.midtrans.com/payment-links/1611305320666",
                //  "https://traffic-app.anabata.com",
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions()),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  setState(() {
                    this.url = url;
                  });
                },
                onLoadStop:
                    (InAppWebViewController controller, String url) async {
                  setState(() {
                    this.url = url;
                  });
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
