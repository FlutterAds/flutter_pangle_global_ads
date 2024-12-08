import 'ad_error_event.dart';
import 'ad_event_action.dart';
export 'ad_error_event.dart';
export 'ad_event_action.dart';

/// 广告事件
class AdEvent {
  AdEvent({required this.posId, required this.action});
  // 广告 id
  final String posId;
  // 操作
  final String action;

  /// 解析 AdEvent
  factory AdEvent.fromJson(Map<dynamic, dynamic> json) {
    String action = json['action'];
    if (action == AdEventAction.onAdError) {
      return AdErrorEvent.fromJson(json);
    } else {
      return AdEvent(
        posId: json['posId'],
        action: action,
      );
    }
  }
}
