import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_pangle_global_ads/flutter_pangle_global_ads.dart';

import 'theme/style.dart';

void main() async {
  // 绑定引擎
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterPangleGlobalAdsPlugin = FlutterPangleGlobalAds();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterPangleGlobalAds.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('$_platformVersion'),
            kDivider,
            ListTile(
              title: const Text('初始化'),
              onTap: () => {FlutterPangleGlobalAds.initAd('8025677')},
            ),
            kDivider,
            ListTile(
              title: const Text('开屏广告'),
              onTap: () => {
                FlutterPangleGlobalAds.showSplashAd('890000078'),
              },
            ),
          ],
        ),
      ),
    );
  }
}
