//
//  SJSocketManager.h
//  SJLiveShow
//
//  Created by SDPMobile on 2017/9/4.
//  Copyright © 2017年 soulja. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSocketManager : NSObject
/*
 *  单利模式
 */
+ (instancetype)defaultManager;

/*
 *  监听返回结果
 */
- (void)on:(NSString *)event callback:(void (^)(NSArray *))callback;

/*
 *  发起事件
 */
- (void)emit:(NSString *)event with:(NSArray *)data;
@end
