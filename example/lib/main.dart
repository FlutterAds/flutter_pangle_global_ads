import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_pangle_global_ads/flutter_pangle_global_ads.dart';

import 'theme/style.dart';
import 'ads_config.dart';

void main() async {
  // Initialize engine
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Initialize
  Future<bool> initAds() async {
    bool result = await FlutterPangleGlobalAds.initAd(
      appId: AdsConfig.appId,
    );
    debugPrint("initAd ===> $result");
    return result;
  }

  /// Show splash ad
  Future<void> showSplashAd() async {
    bool result = await FlutterPangleGlobalAds.showSplashAd(
      AdsConfig.posIdOpenVertical,
    );
    debugPrint("showSplashAd ===> $result");
  }

  /// Request IDFA permission
  Future<void> requestIDFA() async {
    bool result = await FlutterPangleGlobalAds.requestIDFA();
    debugPrint("requestIDFA ===> $result");
  }

  /// Set ad event listener
  Future<void> setAdEvent() async {
    FlutterPangleGlobalAds.onEventListener((event) {
      debugPrint('onEventListener posId:${event.posId} action:${event.action}');
      if (event is AdErrorEvent) {
        debugPrint(
            'onEventListener onAdError posId:${event.posId} errCode:${event.errCode} errMsg:${event.errMsg}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Set ad event listener
    setAdEvent();
    // After initialization success, show splash ad
    initAds().then((value) {
      if (value) {
        showSplashAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pangle Global (FlutterAds)'),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Flutter Ads'),
            ),
            kDivider,
            if (Platform.isIOS) ...[
              kDivider,
              ListTile(
                title: const Text('Request IDFA Permission'),
                onTap: () {
                  requestIDFA();
                },
              ),
            ],
            kDivider,
            ListTile(
              title: const Text('Initialize'),
              onTap: () {
                initAds();
              },
            ),
            kDivider,
            ListTile(
              title: const Text('Splash Ad'),
              onTap: () {
                showSplashAd();
              },
            ),
          ],
        ),
      ),
    );
  }
}
