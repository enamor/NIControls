//
//  KeyBoardTextViewController.m
//  NIControls
//
//  Created by zhouen on 2017/6/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "KeyBoardTextViewController.h"
#import "UIView+keyboard.h"

@interface KeyBoardTextViewController ()
@property (nonatomic, strong)UITextField *textview;
@end

@implementation KeyBoardTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *bntn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:bntn];
    bntn.backgroundColor = [UIColor grayColor];
    
    
    self.textview = [[UITextField alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 64, self.view.frame.size.width, 49)];
    [self.textview addKeyboardObserver];
    _textview.placeholder = @"点击测试键盘监听";

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(text)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:_textview];
    
}

- (void)text
{
    [self.textview resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
