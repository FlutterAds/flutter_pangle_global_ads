#import "FlutterPangleGlobalAdsPlugin.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <PAGAdSDK/PAGAdSDK.h>

@interface FlutterPangleGlobalAdsPlugin()<PAGLAppOpenAdDelegate>
@property(nonatomic, strong) PAGLAppOpenAd *splashAd;
@property(nonatomic, strong) NSMutableDictionary *adPosIdMap;
@end

@implementation FlutterPangleGlobalAdsPlugin

// 单例方便后面复用
+ (instancetype)shared {
    static FlutterPangleGlobalAdsPlugin *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 在 init 方法中初始化字典
- (instancetype)init {
    self = [super init];
    if (self) {
        self.adPosIdMap = [NSMutableDictionary dictionary];
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_pangle_global_ads"
            binaryMessenger:[registrar messenger]];
  FlutterEventChannel* eventChannel=[FlutterEventChannel eventChannelWithName:@"flutter_pangle_global_ads_event" binaryMessenger:[registrar messenger]];

  FlutterPangleGlobalAdsPlugin* instance = [[FlutterPangleGlobalAdsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
  [eventChannel setStreamHandler:instance];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString *methodStr=call.method;
  if ([@"getPlatformVersion" isEqualToString:methodStr]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"requestIDFA" isEqualToString:methodStr]) {
      [self requestIDFA:call result:result];
  }else if ([@"initAd" isEqualToString:methodStr]){
      [self initAd:call result:result];
  } else if ([@"showSplashAd" isEqualToString:methodStr]) {
      [self showSplashAd:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

// 请求 IDFA
- (void) requestIDFA:(FlutterMethodCall*) call result:(FlutterResult) result{
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            BOOL requestResult=status == ATTrackingManagerAuthorizationStatusAuthorized;
            NSLog(@"FlutterPangleGlobalAdsPlugin requestIDFA:%@",requestResult?@"YES":@"NO");
            result(@(requestResult));
        }];
    } else {
        result(@(YES));
    }
}

// 初始化广告
- (void) initAd:(FlutterMethodCall*) call result:(FlutterResult) result{
    NSString *appId=call.arguments[@"appId"];
    BOOL debug = [call.arguments[@"debug"] boolValue];
    
    // 配置
    PAGConfig *config = [PAGConfig shareConfig];
    config.appID = appId;
    // 日志开启
    config.debugLog = debug;
    
    // 初始化SDK
    [PAGSdk startWithConfig:config completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"FlutterPangleGlobalAdsPlugin initAd success");
            result(@(YES));
        } else {
            NSLog(@"FlutterPangleGlobalAdsPlugin initAd failed: %@", error);
            result(@(NO));
        }
    }];
}

// 展示开屏广告
- (void)showSplashAd:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *posId = call.arguments[@"posId"];
    NSInteger timeout = [call.arguments[@"timeout"] integerValue];
    
    // 创建开屏广告请求参数
    PAGAppOpenRequest *request = [PAGAppOpenRequest request];
    request.timeout = timeout / 1000.0; // 转换为秒
    
    // 加载开屏广告
    [PAGLAppOpenAd loadAdWithSlotID:posId request:request completionHandler:^(PAGLAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
        if (error) {
            NSLog(@"FlutterPangleGlobalAdsPlugin loadSplashAd failed: %@", error);
            [self sendErrorEvent:posId error:error];
            return;
        }
        self.splashAd = appOpenAd;
        self.splashAd.delegate = self;
        // 添加广告位ID映射
        [self.adPosIdMap setObject:posId forKey:[NSString stringWithFormat:@"%p", appOpenAd]];
        
        if (self.splashAd) {
            [self.splashAd presentFromRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        }
        // 发送广告事件
        [self sendEvent:posId action:onAdLoaded];
    }];
    result(@(YES));
}

#pragma mark - PAGLAppOpenAdDelegate
// 广告展示失败回调
- (void)adDidShowFail:(id<PAGAdProtocol>)ad error:(NSError *)error{
    NSString *key = [NSString stringWithFormat:@"%p", ad];
    NSString *posId = [self.adPosIdMap objectForKey:key];
    NSLog(@"FlutterPangleGlobalAdsPlugin adDidShowFail posId:%@ error:%@",posId,error.description);
    [self sendErrorEvent:posId error:error];
}
// 广告展示成功回调
- (void)adDidShow:(id<PAGAdProtocol>)ad {
    NSString *key = [NSString stringWithFormat:@"%p", ad];
    NSString *posId = [self.adPosIdMap objectForKey:key];
    NSLog(@"FlutterPangleGlobalAdsPlugin adDidShow posId:%@",posId);
    [self sendEvent:posId action:onAdShowed];
}

// 广告点击回调
- (void)adDidClick:(id<PAGAdProtocol>)ad {
    NSString *key = [NSString stringWithFormat:@"%p", ad];
    NSString *posId = [self.adPosIdMap objectForKey:key];
    NSLog(@"FlutterPangleGlobalAdsPlugin adDidClick posId:%@",posId);
    [self sendEvent:posId action:onAdClicked];
}

// 广告关闭回调
- (void)adDidDismiss:(id<PAGAdProtocol>)ad {
    NSString *key = [NSString stringWithFormat:@"%p", ad];
    NSString *posId = [self.adPosIdMap objectForKey:key];
    // 广告关闭后移除映射关系
    [self.adPosIdMap removeObjectForKey:key];
    NSLog(@"FlutterPangleGlobalAdsPlugin adDidDismiss posId:%@",posId);
    [self sendEvent:posId action:onAdClosed];
}


#pragma mark - FlutterStreamHandler

- (FlutterError *)onCancelWithArguments:(id)arguments{
    self.eventSink = nil;
    return nil;
}
- (FlutterError *)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)events{
    self.eventSink = events;
    return nil;
}

- (void)addEvent:(NSObject *) event{
    if(self.eventSink){
        self.eventSink(event);
    }
}

// 发送广告事件
- (void)sendEvent:(NSString *)posId action:(NSString *)action{
    FPGAdEvent *event=[[FPGAdEvent alloc] initWithPosId:posId action:action];
    [self addEvent:event.toMap];
}

// 发送广告错误事件
- (void)sendErrorEvent:(NSString *)posId error:(NSError * _Nullable) err{
    FPGAdErrorEvent *event=[[FPGAdErrorEvent alloc] initWithPosId:posId errCode:err.code errMsg:err.description];
    [self addEvent:event.toMap];
}
@end
