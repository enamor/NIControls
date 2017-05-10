# NIControls
自定义控件集锦 ，常用功能集锦

1 、图片上文字下按钮

2、倒计时

**使用方式**

导入 NICountDown.h

~~~objective-c
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

~~~



3、系统AlertView 和 ActionSheet的封装（易用）对于iOS8.3做了区分

**使用方式 **

导入NSObject+AlertBlock.h 如下代码

~~~objective-c
		//AlertView
        [self alertViewWithBlock:^(NSInteger buttonIndex) {
            NSLog(@"%d",buttonIndex);
        } title:@"温馨提示" message:@"确定要流量观看吗" cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        //ActionSheet
        [self actionSheetWithBlock:^(NSInteger buttonIndex) {
            NSLog(@"%d",buttonIndex);
        } title:nil cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"手机相册", nil];
~~~



