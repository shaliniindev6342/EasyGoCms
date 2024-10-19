
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:phone_state_example/Screen/home_screen.dart';

class DataAlloting extends StatefulWidget {
  const DataAlloting({super.key});

  @override
  State<DataAlloting> createState() => _DataAllotingState();
}

class _DataAllotingState extends State<DataAlloting> {

  InAppWebViewController? webViewController;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFCC0001),
          title: const Text(
            'EasyGoCms',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logoeasygocms2.jpeg'),
          ),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.offAll(() => const HomeScreen());
                  },
                  child: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
                
              ],
            )
          ],
        ),
         body: Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri("https://easygocms.com/autodialerapp/data_allot.php?adminid=123&userid=user"),
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    clearCache: true,
                    supportZoom: false,
                  ),
                ),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onLoadStop: (controller, url) async {
                  debugPrint("Finished loading: $url");
                  await controller.evaluateJavascript(source: """
                    var meta = document.createElement('meta');
                    meta.name = 'viewport';
                    meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
                    document.getElementsByTagName('head')[0].appendChild(meta);
                  """);
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    // _progress = progress / 100;
                  });
                },
              ),
              // if (_progress < 1)
              //   Center(
              //     child: CircularProgressIndicator(
              //       value: _progress,
              //       color: const Color.fromARGB(255, 248, 84, 19),
              //     ),
              //   ),
            ],
          ),
        bottomNavigationBar: Container(
          color: const Color(0xFFCC0001),
          child: const Text(
            'By : Manthan IT Solutions',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
