//
//  FPGAdEvent.h
//  flutter_pangle_global_ads
//
//  Created by zero on 2024/12/04.
//

#import <Foundation/Foundation.h>
// 广告操作事件
// 广告错误
static NSString *const onAdError=@"onAdError";
// 广告加载成功
static NSString *const onAdLoaded=@"onAdLoaded";
// 广告曝光
static NSString *const onAdShowed=@"onAdShowed";
// 广告关闭（计时结束或者用户点击关闭）
static NSString *const onAdClosed=@"onAdClosed";
// 广告点击
static NSString * const onAdClicked=@"onAdClicked";
// 获得广告激励
static NSString *const onAdReward=@"onAdReward";

// 广告事件
@interface FPGAdEvent : NSObject
// 广告id
@property (copy,nonatomic) NSString *posId;
// 操作事件
@property (copy,nonatomic) NSString *action;
// 构造广告事件
- (id) initWithPosId:(NSString *) posId action:(NSString *) action;
// 转换为 map
- (NSDictionary *) toMap;
@end
