import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pangle_global_ads_method_channel.dart';

abstract class FlutterPangleGlobalAdsPlatform extends PlatformInterface {
  /// Constructs a FlutterPangleGlobalAdsPlatform.
  FlutterPangleGlobalAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPangleGlobalAdsPlatform _instance = MethodChannelFlutterPangleGlobalAds();

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
}
