//
//  UIAlertController+Block.h
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (AlertBlock)
typedef void(^NIAlertCallBackBlock)(NSInteger buttonIndex);


@property (nonatomic, copy) NIAlertCallBackBlock _Nullable callBackBlock;

/*
 系统AlertView
 */
- (void)alertViewWithBlock:(nullable NIAlertCallBackBlock)callBackBlock
                        title:(nullable NSString *)title
                       message:(nullable NSString *)message
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;


/*
 系统ActionSheet
 */
- (void)actionSheetWithBlock:(nullable NIAlertCallBackBlock)callBackBlock
                       title:(nullable NSString *)title
           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
           otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end
