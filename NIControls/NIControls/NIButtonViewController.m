//
//  NIButtonViewController.m
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "NIButtonViewController.h"
#import "NIButton.h"

@interface NIButtonViewController ()

@end

@implementation NIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NIButton *manBtn = [[NIButton alloc] initWithFrame:CGRectMake(100, 200 , 40, 60)];
    [manBtn setTitle:@"男" forState:UIControlStateNormal];
    [manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    manBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [manBtn setImage:[UIImage imageNamed:@"ic_woman_xuan@2x"] forState:UIControlStateNormal];
    [manBtn addTarget:self action:@selector(sexBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:manBtn];


    
    // Do any additional setup after loading the view.
}

- (void)sexBtnAction:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
