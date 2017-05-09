//
//  UIActionSheet+Block.m
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>

static NSString *UIAlertViewKey = @"UIAlertViewKey";

@interface UIActionSheet ()<UIActionSheetDelegate>


@end
@implementation UIActionSheet (Block)

+ (void)actionSheetWithBlock:(ActionSheetCallBackBlock)callBackBlock title:(NSString *)title showInView:(UIView *)view cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles,nil];
    NSString *other = nil;
    va_list args;
    int count = 0;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [actionSheet addButtonWithTitle:other];
            count ++;
        }
        va_end(args);
    }
    [actionSheet addButtonWithTitle:cancelButtonTitle];
    actionSheet.cancelButtonIndex = count + 1;
    actionSheet.delegate = actionSheet;
    [actionSheet showInView:view];
    actionSheet.callBackBlock = callBackBlock;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callBackBlock) {
        self.callBackBlock(buttonIndex);
    }
}



- (void)setCallBackBlock:(ActionSheetCallBackBlock)callBackBlock {
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &UIAlertViewKey, callBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

- (ActionSheetCallBackBlock)callBackBlock {
    
    return objc_getAssociatedObject(self, &UIAlertViewKey);
}

@end
