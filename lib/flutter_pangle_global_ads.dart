import 'package:flutter/foundation.dart';

import 'flutter_pangle_global_ads_platform_interface.dart';

class FlutterPangleGlobalAds {
  static Future<String?> getPlatformVersion() {
    return FlutterPangleGlobalAdsPlatform.instance.getPlatformVersion();
  }

  /// 初始化广告
  /// [appId] 应用ID
  /// [appIcon] 应用 icon
  /// [debug] 是否是debug模式
  static Future<void> initAd(String appId,
      {String? appIcon, bool debug = kDebugMode}) {
    return FlutterPangleGlobalAdsPlatform.instance
        .initAd(appId, appIcon: appIcon, debug: debug);
  }

  /// 展示开屏广告
  /// [posId] 广告位ID
  /// [timeout] 超时时间
  static Future<void> showSplashAd(String posId, {int timeout = 3000}) {
    return FlutterPangleGlobalAdsPlatform.instance
        .showSplashAd(posId, timeout: timeout);
  }
}
