//
//  FPGAdErrorEvent.m
//  flutter_pangle_global_ads
//
//  Created by zero on 2024/12/04.
//

#import "FPGAdErrorEvent.h"

@implementation FPGAdErrorEvent
- (id)initWithPosId:(NSString *)posId errCode:(NSInteger)errCode errMsg:(NSString *)errMsg{
    self.posId=posId;
    self.action=onAdError;
    self.errCode=errCode;
    self.errMsg=errMsg;
    return self;
}

- (id)initWithPosId:(NSString *)posId error:(NSError *)error{
    return [self initWithPosId:posId errCode:error.code errMsg:error.localizedDescription];
}

- (NSDictionary *)toMap{
    NSMutableDictionary *errData=[[NSMutableDictionary alloc] initWithDictionary:[super toMap]];
    [errData setObject:@(self.errCode) forKey:@"errCode"];
    [errData setObject:self.errMsg forKey:@"errMsg"];
    return errData;
}
@end
