//
//  SJLiveViewController.m
//  SJLiveShow
//
//  Created by SoulJa on 2017/9/3.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import "SJLiveViewController.h"
#import "SJLiveView.h"

@interface SJLiveViewController ()

@end

@implementation SJLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.roomName;
    
    SJLiveView *liveView = [[SJLiveView alloc] initWithRoomId:self.roomId Frame:self.view.bounds];
    
    [self.view addSubview:liveView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //去除房间
    [[SJSocketManager defaultManager] emit:@"deleteRoom" with:@[self.roomId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
