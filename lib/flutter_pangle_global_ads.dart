
import 'flutter_pangle_global_ads_platform_interface.dart';

class FlutterPangleGlobalAds {
  Future<String?> getPlatformVersion() {
    return FlutterPangleGlobalAdsPlatform.instance.getPlatformVersion();
  }
}
