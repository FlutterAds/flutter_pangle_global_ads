//
//  FPGAdEvent.m
//  flutter_pangle_global_ads
//
//  Created by zero on 2024/12/04.
//

#import "FPGAdEvent.h"

@implementation FPGAdEvent
- (id)initWithPosId:(NSString *)posId action:(NSString *)action{
    self.posId=posId;
    self.action=action;
    return self;
}

- (NSDictionary *)toMap{
    NSDictionary *data=@{@"posId":self.posId,@"action":self.action};
    return  data;
}
@end
