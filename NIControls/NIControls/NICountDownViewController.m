//
//  NICountDownViewController.m
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "NICountDownViewController.h"
#import "NICountDown.h"

@interface NICountDownViewController ()
@property (nonatomic, weak) UIButton *codeBtn;

@end

@implementation NICountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *countBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 30)];
    [countBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    countBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    countBtn.backgroundColor = [UIColor greenColor];
    [countBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [countBtn addTarget:self action:@selector(getCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countBtn];
    self.codeBtn = countBtn;
    
}

- (void)getCodeAction {
    _codeBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 120, 30)];
    
    NICountDown *countDown = [[NICountDown alloc] init];
    __weak typeof(self) weakSelf = self;
    [countDown countDown:60 completeBlock:^(int secs) {
        if (secs == 0) {
            weakSelf.codeBtn.enabled = YES;
            [weakSelf.codeBtn setTitle:@"倒计时" forState:UIControlStateNormal];
        }else{
            weakSelf.codeBtn.enabled = NO;
            [weakSelf.codeBtn setTitle:[NSString stringWithFormat:@"%is后重新获取",secs] forState:UIControlStateNormal];
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
