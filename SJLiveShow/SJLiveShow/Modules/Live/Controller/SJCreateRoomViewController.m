//
//  SJCreateRoomViewController.m
//  SJLiveShow
//
//  Created by SDPMobile on 2017/9/5.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import "SJCreateRoomViewController.h"
/**  直播页面 **/
#import "SJLiveViewController.h"

@interface SJCreateRoomViewController ()
/**  房间名称 **/
@property (nonatomic, strong) UITextField *tfRoomNameInput;
@end

@implementation SJCreateRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Nav
    [self initNav];
    
    //设置子视图
    [self initSubviews];
    
    //监听事件
    [self addEventListener];
}

#pragma mark - 设置Nav
- (void)initNav {
    self.title = @"创建房间";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始采集" style:UIBarButtonItemStyleDone target:self action:@selector(tapLiveBtn)];
}

#pragma mark - 设置子视图
- (void)initSubviews {
    __weak SJCreateRoomViewController *weakSelf = self;
    
    _tfRoomNameInput = [[UITextField alloc] init];
    _tfRoomNameInput.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_tfRoomNameInput];
    [_tfRoomNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.view.mas_leading).offset(30);
        make.trailing.equalTo(weakSelf.view.mas_trailing).offset(-30);
        make.top.equalTo(weakSelf.view.mas_top).offset(50);
        make.height.equalTo(@40);
    }];
}

#pragma mark - 点击开始采集
- (void)tapLiveBtn {
    if ([_tfRoomNameInput.text isEqualToString:@""]) {
        return;
    }
    
    NSString *roomId = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
    NSString *roomName = _tfRoomNameInput.text;
    
    [[SJSocketManager defaultManager] emit:@"createRoom" with:@[roomId,roomName]];
}

#pragma mark - 监听事件
- (void)addEventListener {
    [[SJSocketManager defaultManager] on:@"createRoomResult" callback:^(NSArray *data) {
        NSString *roomId = data[0];
        NSString *roomName = data[1];
        SJLiveViewController *vc = [[SJLiveViewController alloc] init];
        vc.roomId = roomId;
        vc.roomName = roomName;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
