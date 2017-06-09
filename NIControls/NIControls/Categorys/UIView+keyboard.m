//
//  UIView+keyboard.m
//  NIControls
//
//  Created by zhouen on 2017/6/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "UIView+keyboard.h"


//typedef NS_ENUM(NSInteger, UIViewAnimationCurve) {
//    UIViewAnimationCurveEaseInOut,         // 开始时慢，中间快，结束时慢
//    UIViewAnimationCurveEaseIn,            // 开始慢，然后加速
//    UIViewAnimationCurveEaseOut,           // 逐渐减速
//    UIViewAnimationCurveLinear             // 匀速
//};


@implementation UIView (keyboard)

-(void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




-(void)keyboardChangeFrame:(NSNotification*)noti;
{
    CGFloat heigt = self.superview.frame.size.height;
    CGRect bRect = self.frame;

    CGRect rect= [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardheight = rect.size.height;
    CGFloat duration=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat curve=[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]doubleValue];
    
    bRect.origin.y = heigt - bRect.size.height - keyboardheight;
    
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:duration animations:^{
        self.frame = bRect;
    } completion:^(BOOL finished) {
        
    }];
    
}


-(void)keyboardHide:(NSNotification *)noti
{
    [self endEditing:YES];
    CGFloat heigt = self.superview.frame.size.height;
    CGRect rect = self.frame;
    rect.origin.y = heigt - rect.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
    
}
@end
