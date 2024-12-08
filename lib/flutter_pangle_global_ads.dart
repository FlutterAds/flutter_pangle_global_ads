import 'package:flutter/foundation.dart';

import 'event/ad_event_handler.dart';
import 'flutter_pangle_global_ads_platform_interface.dart';
export 'event/ad_event.dart';
export 'event/ad_event_action.dart';
export 'event/ad_error_event.dart';

/// 广告管理类
/// 提供广告的初始化、展示、监听等方法
/// 使用前需要先调用 [initAd] 方法进行初始化
class FlutterPangleGlobalAds {
  static Future<String?> getPlatformVersion() {
    return FlutterPangleGlobalAdsPlatform.instance.getPlatformVersion();
  }

  /// 事件监听
  /// [onAdEventListener] 事件回调
  static Future<void> onEventListener(OnAdEventListener onAdEventListener) {
    return FlutterPangleGlobalAdsPlatform.instance
        .onEventListener(onAdEventListener);
  }

  /// 请求 IDFA 权限 (仅 iOS)
  static Future<bool> requestIDFA() {
    return FlutterPangleGlobalAdsPlatform.instance.requestIDFA();
  }

  /// 初始化广告
  /// [appId] 应用ID
  /// [debug] 是否是debug模式
  static Future<bool> initAd({required String appId, bool debug = kDebugMode}) {
    return FlutterPangleGlobalAdsPlatform.instance.initAd(appId, debug: debug);
  }

  /// 展示开屏广告
  /// [posId] 广告位ID
  /// [timeout] 超时时间
  static Future<bool> showSplashAd(String posId, {int timeout = 3000}) {
    return FlutterPangleGlobalAdsPlatform.instance
        .showSplashAd(posId, timeout: timeout);
  }
}
