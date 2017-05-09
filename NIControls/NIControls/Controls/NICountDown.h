//
//  NICountDown.h
//  FYJI
//
//  Created by zhouen on 2017/5/5.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NICountDown : NSObject
-(void)countDown:(int)secs completeBlock:(void (^)(int secs))completeBlock;

-(void)destoryTimer;
@end
