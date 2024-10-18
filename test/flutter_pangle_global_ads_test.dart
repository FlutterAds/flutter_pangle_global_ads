import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pangle_global_ads/flutter_pangle_global_ads.dart';
import 'package:flutter_pangle_global_ads/flutter_pangle_global_ads_platform_interface.dart';
import 'package:flutter_pangle_global_ads/flutter_pangle_global_ads_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPangleGlobalAdsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPangleGlobalAdsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPangleGlobalAdsPlatform initialPlatform = FlutterPangleGlobalAdsPlatform.instance;

  test('$MethodChannelFlutterPangleGlobalAds is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPangleGlobalAds>());
  });

  test('getPlatformVersion', () async {
    FlutterPangleGlobalAds flutterPangleGlobalAdsPlugin = FlutterPangleGlobalAds();
    MockFlutterPangleGlobalAdsPlatform fakePlatform = MockFlutterPangleGlobalAdsPlatform();
    FlutterPangleGlobalAdsPlatform.instance = fakePlatform;

    expect(await flutterPangleGlobalAdsPlugin.getPlatformVersion(), '42');
  });
}
