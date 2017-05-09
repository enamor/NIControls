//
//  NICountDown.m
//  FYJI
//
//  Created by zhouen on 2017/5/5.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "NICountDown.h"
@interface NICountDown ()
@property(nonatomic,retain) dispatch_source_t timer;
@end
@implementation NICountDown

/**
 秒倒计时

 @param secs 总秒数
 @param completeBlock 值变化
 */
-(void)countDown:(int)secs completeBlock:(void (^)(int secs))completeBlock{
    __block int timeout = secs;
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                _timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(0);
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    completeBlock(timeout);
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
}

/**
 *  主动销毁定时器
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
@end
