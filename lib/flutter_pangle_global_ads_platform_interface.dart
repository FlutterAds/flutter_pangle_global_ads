import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'event/ad_event_handler.dart';
import 'flutter_pangle_global_ads_method_channel.dart';

abstract class FlutterPangleGlobalAdsPlatform extends PlatformInterface {
  /// Constructs a FlutterPangleGlobalAdsPlatform.
  FlutterPangleGlobalAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPangleGlobalAdsPlatform _instance =
      MethodChannelFlutterPangleGlobalAds();

  /// The default instance of [FlutterPangleGlobalAdsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPangleGlobalAds].
  static FlutterPangleGlobalAdsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPangleGlobalAdsPlatform] when
  /// they register themselves.
  static set instance(FlutterPangleGlobalAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  /// 事件监听
  /// [onAdEventListener] 事件回调
  Future<void> onEventListener(OnAdEventListener onAdEventListener) {
    throw UnimplementedError('onEventListener() has not been implemented.');
  }

  /// 初始化广告
  /// [appId] 应用ID
  /// [appIcon] 应用 icon
  /// [debug] 是否是debug模式
  Future<bool> initAd(String appId,
      {String? appIcon, bool debug = kDebugMode}) {
    throw UnimplementedError('initAd() has not been implemented.');
  }

  /// 展示开屏广告
  /// [posId] 广告位ID
  /// [timeout] 超时时间
  Future<bool> showSplashAd(String posId, {int timeout = 3000}) {
    throw UnimplementedError('showSplashAd() has not been implemented.');
  }

  /// 展示激励视频广告
  /// [posId] 广告位ID
  Future<bool> showRewardVideoAd(String posId) {
    throw UnimplementedError('showRewardVideoAd() has not been implemented.');
  }

  /// 展示插屏广告
  /// [posId] 广告位ID
  Future<bool> showInterAd(String posId) {
    throw UnimplementedError('showInterAd() has not been implemented.');
  }

  /// 请求 IDFA 权限 (仅 iOS)
  Future<bool> requestIDFA() {
    throw UnimplementedError('requestIDFA() has not been implemented.');
  }
}
