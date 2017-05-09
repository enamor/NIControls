//
//  ViewController.m
//  NIControls
//
//  Created by zhouen on 2017/5/9.
//  Copyright © 2017年 zhouen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *controllers;
@end

static NSString *const identifier = @"controlsList";
@implementation ViewController

//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_initUI];
    [self p_initDatas];
    [self p_initObserver];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Protocol
#pragma mark ------ UITextFieldDelegate
#pragma mark ------ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}
#pragma mark ------ UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *vcStr = _controllers[indexPath.row];
    id myObj = [[NSClassFromString(vcStr) alloc] init];
    if (myObj) {
        [self.navigationController pushViewController:myObj animated:YES];
    }
}
#pragma mark ------ UIScrollViewDelegate



//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Override

#pragma mark ------ Public

#pragma mark ------ IBAction


//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ Private
- (void)p_initUI {
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:[UIView new]];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor colorWithWhite:0.4 alpha:0.3];
    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)p_initDatas {
    _titles = @[@"图片文字上下Button",
                @"倒计时"];
    _controllers = @[@"NIButtonViewController",
                     @"NICountDownViewController"];
}

- (void)p_initObserver {
    
}


//////////////////////////////////////////////////////////////////////////////
#pragma mark ------ getter setter


@end
