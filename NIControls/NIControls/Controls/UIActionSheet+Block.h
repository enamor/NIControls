//
//  UIActionSheet+Block.h
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionSheetCallBackBlock)(NSInteger buttonIndex);

@interface UIActionSheet (Block)

@property (nonatomic, copy) ActionSheetCallBackBlock callBackBlock;

+ (void)actionSheetWithBlock:(ActionSheetCallBackBlock)callBackBlock
                               title:(nullable NSString *)title
                          showInView:(nonnull UIView *)view
                   cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                   otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
@end
