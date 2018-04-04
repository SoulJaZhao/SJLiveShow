//
//  SJLiveView.h
//  SJLiveShow
//
//  Created by SoulJa on 2017/9/3.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <LFLiveKit/LFLiveKit.h>

@interface SJLiveView : UIView <LFLiveSessionDelegate>
@property (nonatomic,strong) LFLiveSession *session;

- (instancetype)initWithRoomId:(NSString *)roomId Frame:(CGRect)frame;
@end
