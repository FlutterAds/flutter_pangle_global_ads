import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'event/ad_event_handler.dart';
import 'flutter_pangle_global_ads_platform_interface.dart';

/// An implementation of [FlutterPangleGlobalAdsPlatform] that uses method channels.
class MethodChannelFlutterPangleGlobalAds
    extends FlutterPangleGlobalAdsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pangle_global_ads');

  /// 事件通道
  @visibleForTesting
  final eventChannel = const EventChannel('flutter_pangle_global_ads_event');

  ///事件回调
  /// [onAdEventListener] 事件回调
  @override
  Future<void> onEventListener(OnAdEventListener onAdEventListener) async {
    eventChannel.receiveBroadcastStream().listen((data) {
      hanleAdEvent(data, onAdEventListener);
    });
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> requestIDFA() async {
    return await methodChannel.invokeMethod('requestIDFA');
  }

  @override
  Future<bool> initAd(String appId,
      {String? appIcon, bool debug = kDebugMode}) async {
    return await methodChannel.invokeMethod(
        'initAd', {'appId': appId, 'appIcon': appIcon, 'debug': debug});
  }

  @override
  Future<bool> showSplashAd(String posId, {int timeout = 3000}) async {
    return await methodChannel
        .invokeMethod('showSplashAd', {'posId': posId, 'timeout': timeout});
  }

  @override
  Future<bool> showRewardVideoAd(String posId) async {
    return await methodChannel
        .invokeMethod('showRewardVideoAd', {'posId': posId});
  }

  @override
  Future<bool> showInterAd(String posId) async {
    return await methodChannel.invokeMethod('showInterAd', {'posId': posId});
  }
}
