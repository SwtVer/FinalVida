import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vida/provider/userprovider.dart';
import 'package:webview_flutter/platform_interface.dart';

import 'package:webview_flutter/webview_flutter.dart';

class EsewaEpay extends StatefulWidget {
  static const String routeName = '/esewa-payment';
  final String totalAmount;
  const EsewaEpay({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<EsewaEpay> {
  late var amount;
  double result = 0;
  //Completer<WebViewController> _controller = Completer<WebViewController>();

  late WebViewController _webViewController;

  String testUrl = "https://pub.dev/packages/webview_flutter";

  _loadHTMLfromAsset() async {
    String file = await rootBundle.loadString("assets/epay_request.html");
    _webViewController.loadUrl(Uri.dataFromString(file,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  

  @override
  void initState() {
    super.initState();
    amount = widget.totalAmount;
    result = double.parse(amount);
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  // ePay deatils
  

  @override
  Widget build(BuildContext context) {
    double tAmt =result; //1000
  double amt = 800;
  double txAmt = 100;
  double psc = 50;
  double pdc = 50;
  String scd = "EPAYTEST";
  String su = "https://github.com/kaledai";
  String fu = "https://refactoring.guru/design-patterns/factory-method";
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       String pid = UniqueKey().toString();
      //       _webViewController.evaluateJavascript(
      //           'requestPayment(tAmt = $tAmt, amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF1B3834),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: //Column(
        //children: [
          //Text('$result'),
          WebView(
            initialUrl: "about:blank",
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: Set.from([
              JavascriptChannel(
                name: "message",
                onMessageReceived: (message) {},
              ),
            ]),
            onPageFinished: (data) {
              setState(() {
                String pid = UniqueKey().toString();
                _webViewController.evaluateJavascript(
                    'requestPayment(tAmt = $tAmt,amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');
              });
            },
            onWebViewCreated: (webViewController) {
              // _controller.complete(webViewController);
              _webViewController = webViewController;
              _loadHTMLfromAsset();
            },
          ),
        //],
      //),
    );
  }
}
