//
//  SJSocketManager.m
//  SJLiveShow
//
//  Created by SDPMobile on 2017/9/4.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import "SJSocketManager.h"
#import <SocketIO/SocketIO-Swift.h>

static NSString * const kSJWebScoketUrlString = @"ws://10.241.90.109:7349";

@interface SJSocketManager ()
@property (nonatomic, strong) SocketIOClient *clientSocket;
@end

@implementation SJSocketManager

#pragma mark - 单利模式
+ (instancetype)defaultManager {
    static SJSocketManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SJSocketManager alloc] init];
    });
    return manager;
}

#pragma mark - 初始化方法
- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        NSURL *url = [NSURL URLWithString:kSJWebScoketUrlString];
        //连接socket
        _clientSocket = [[SocketIOClient alloc] initWithSocketURL:url config:@{@"log": @YES, @"forcePolling": @YES}];
        [_clientSocket connect];
    }
    return self;
}

#pragma mark - 监听返回结果
- (void)on:(NSString *)event callback:(void (^)(NSArray *))callback {
    [_clientSocket on:event callback:^(NSArray * data, SocketAckEmitter * ack) {
        callback(data);
    }];
}

#pragma mark - 发送事件
- (void)emit:(NSString *)event with:(NSArray *)data {
    [_clientSocket emit:event with:data];
}
@end
