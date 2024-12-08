#import <Flutter/Flutter.h>
#import "FPGAdEvent.h"
#import "FPGAdErrorEvent.h"

@interface FlutterPangleGlobalAdsPlugin : NSObject<FlutterPlugin,FlutterStreamHandler>
+ (instancetype)shared; // 共享实例
@property (strong,nonatomic) FlutterEventSink eventSink;// 事件

- (void)addEvent:(NSObject *) event;
@end
