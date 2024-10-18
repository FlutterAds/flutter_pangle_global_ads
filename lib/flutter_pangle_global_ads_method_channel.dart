import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pangle_global_ads_platform_interface.dart';

/// An implementation of [FlutterPangleGlobalAdsPlatform] that uses method channels.
class MethodChannelFlutterPangleGlobalAds extends FlutterPangleGlobalAdsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pangle_global_ads');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
