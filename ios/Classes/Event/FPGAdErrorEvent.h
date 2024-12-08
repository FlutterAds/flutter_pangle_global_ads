//
//  FPGAdErrorEvent.h
//  flutter_pangle_global_ads
//
//  Created by zero on 2024/12/04.
//

#import "FPGAdEvent.h"

// 广告错误事件
@interface FPGAdErrorEvent : FPGAdEvent
// 错误码
@property (assign,nonatomic) NSInteger errCode;
// 错误信息
@property (copy,nonatomic) NSString *errMsg;

-(id) initWithPosId:(NSString *)posId errCode:(NSInteger)errCode errMsg:(NSString*) errMsg;
-(id) initWithPosId:(NSString *)posId error:(NSError *)error;
@end
