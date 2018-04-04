//
//  SJMoviePlayerViewController.m
//  SJLiveShow
//
//  Created by SoulJa on 2017/9/3.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import "SJMoviePlayerViewController.h"
#import <IJKMediaFramework/IJKMediaPlayer.h>

static NSString * const kRTMPUrlString = @"rtmp://10.241.90.109:1990/liveApp/";

@interface SJMoviePlayerViewController ()
@property (nonatomic,strong) IJKFFMoviePlayerController *player;
@end

@implementation SJMoviePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kRTMPUrlString,self.roomId]];
    
    // 创建IJKFFMoviePlayerController：专门用来直播，传入拉流地址就好了
    IJKFFMoviePlayerController *playerVc = [[IJKFFMoviePlayerController alloc] initWithContentURL:url withOptions:nil];
    // 准备播放
    [playerVc prepareToPlay];
    
    // 强引用，防止被销毁
    _player = playerVc;
    
    playerVc.view.frame = [UIScreen mainScreen].bounds;
    
    [self.view insertSubview:playerVc.view atIndex:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    if ([_player isPlaying]) {
        [_player pause];
    }
    [_player stop];
    [_player shutdown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
