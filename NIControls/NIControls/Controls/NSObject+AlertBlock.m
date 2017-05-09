//
//  UIAlertController+Block.m
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "NSObject+AlertBlock.h"
#import <objc/runtime.h>

#define SYSTEM_VERSION [[UIDevice currentDevice].systemVersion floatValue]

@interface NSObject ()<UIAlertViewDelegate,UIActionSheetDelegate>

@end

static NSString *kCallBackBlock = @"CallBackBlock";
@implementation NSObject (AlertBlock)

//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Protocol
#pragma mark ------ UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callBackBlock) {
        self.callBackBlock(buttonIndex);
    }
}
- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
    
}
#pragma mark ------ UITableViewDataSource
#pragma mark ------ UITableViewDelegate
#pragma mark ------ UIScrollViewDelegate



//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Override

#pragma mark ------ Public
- (void)actionSheetWithBlock:(NIAlertCallBackBlock)callBackBlock title:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {

    if (SYSTEM_VERSION < 8.3) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles,nil];
        NSString *other = nil;
        int count = 0;
        va_list args;
        if (otherButtonTitles) {
            va_start(args, otherButtonTitles);
            while ((other = va_arg(args, NSString*))) {
                [actionSheet addButtonWithTitle:other];
                count ++;
            }
            va_end(args);
        }
        if (cancelButtonTitle) {
            [actionSheet addButtonWithTitle:cancelButtonTitle];
            actionSheet.cancelButtonIndex = count + 1;
        }
        actionSheet.delegate = self;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    } else {
        UIAlertController *actionSheetVC  = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        NSMutableArray *titles = [NSMutableArray array];
        if (otherButtonTitles) {
            [titles addObject:otherButtonTitles];
        }
        NSString *other = nil;
        va_list args;
        if (otherButtonTitles) {
            va_start(args, otherButtonTitles);
            while ((other = va_arg(args, NSString*))) {
                [titles addObject:other];
            }
            va_end(args);
        }
        for (NSString *str in titles) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                
                for (int i = 0; i < titles.count; i++) {
                    if ([titles[i] isEqualToString:action.title]) {
                        if (self.callBackBlock) {
                            self.callBackBlock(i);
                        }
                    }
                }
                
                
            }];
            [actionSheetVC addAction:cancelAction];
        }
        
        if (cancelButtonTitle) {
            [titles addObject:cancelButtonTitle];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                if (self.callBackBlock) {
                    self.callBackBlock(titles.count - 1);
                }
            }];
            [actionSheetVC addAction:cancelAction];
            
        }
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:actionSheetVC animated:YES completion:nil];
    }
    
    self.callBackBlock = callBackBlock;
    
}

#pragma mark ------ IBAction


//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Private
- (void)p_initUI {
    
}

- (void)p_initDatas {
    
}

- (void)p_initObserver {
    
}


//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ getter setter
- (void)setCallBackBlock:(NIAlertCallBackBlock)callBackBlock {
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &kCallBackBlock, callBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
}

- (NIAlertCallBackBlock)callBackBlock {
    
    return objc_getAssociatedObject(self, &kCallBackBlock);
}
@end
