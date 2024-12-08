import 'ad_event.dart';

/// 广告错误事件
class AdErrorEvent extends AdEvent {
  final int errCode;
  final String? errMsg;

  AdErrorEvent({
    required String posId,
    required String action,
    required this.errCode,
    this.errMsg,
  }) : super(posId: posId, action: action);

  // 解析 json 为错误事件对象
  factory AdErrorEvent.fromJson(Map<dynamic, dynamic> json) {
    return AdErrorEvent(
      posId: json['posId'],
      action: AdEventAction.onAdError,
      errCode: json['errCode'],
      errMsg: json['errMsg'],
    );
  }
}
