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

/**
 
 下面是 <stdarg.h> 里面重要的几个宏定义如下：
 typedef char* va_list;
 void va_start ( va_list ap, prev_param ); // ANSI version
 type va_arg ( va_list ap, type );
 void va_end ( va_list ap );
 va_list 是一个字符指针，可以理解为指向当前参数的一个指针，取参必须通过这个指针进行。
 <Step 1> 在调用参数表之前，定义一个 va_list 类型的变量，(假设va_list 类型变量被定义为ap)；
 <Step 2> 然后应该对ap 进行初始化，让它指向可变参数表里面的第一个参数，这是通过 va_start 来实现的，第一个参数是 ap 本身，第二个参数是在变参表前面紧挨着的一个变量,即“...”之前的那个参数；
 <Step 3> 然后是获取参数，调用va_arg，它的第一个参数是ap，第二个参数是要获取的参数的指定类型，然后返回这个指定类型的值，并且把 ap 的位置指向变参表的下一个变量位置；
 <Step 4> 获取所有的参数之后，我们有必要将这个 ap 指针关掉，以免发生危险，方法是调用 va_end，他是输入的参数 ap 置为 NULL，应该养成获取完参数表之后关闭指针的习惯。说白了，就是让我们的程序具有健壮性。通常va_start和va_end是成对出现。
 
 */

//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Protocol
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//以下去除过期api警告
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callBackBlock) {
        self.callBackBlock(buttonIndex);
    }
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.callBackBlock) {
        self.callBackBlock(buttonIndex);
    }
}

#pragma mark ------ UITableViewDataSource
#pragma mark ------ UITableViewDelegate
#pragma mark ------ UIScrollViewDelegate



//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Override

#pragma mark ------ Public

- (void)alertViewWithBlock:(NIAlertCallBackBlock)callBackBlock title:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    
    if (SYSTEM_VERSION < 8.3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: otherButtonTitles, nil];
        
        NSString *other = nil;
        va_list args;
        if (otherButtonTitles) {
            va_start(args, otherButtonTitles);
            while ((other = va_arg(args, NSString*))) {
                [alert addButtonWithTitle:other];
            }
            va_end(args);
        }
        alert.delegate = self;
        [alert show];
    } else {
        UIAlertController *alertViewVC  = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
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
            [alertViewVC addAction:cancelAction];
        }
        
        if (cancelButtonTitle) {
            [titles insertObject:cancelButtonTitle atIndex:0];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
                if (self.callBackBlock) {
                    self.callBackBlock(0);
                }
            }];
            [alertViewVC addAction:cancelAction];
            
        }
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertViewVC animated:YES completion:nil];
    }
    self.callBackBlock = callBackBlock;
}


#pragma mark ActionSheet
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

#pragma clang diagnostic pop
@end
