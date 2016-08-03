//
//  GCDGroup.h
//  GCD
//
//  Created by WangQiao on 16/8/2.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDGroup : NSObject

@property (strong, nonatomic, readonly) dispatch_group_t dispatchGroup;

#pragma 初始化
- (instancetype)init;

#pragma mark - 用法
- (void)enter;
- (void)leave;
- (void)wait;
- (BOOL)wait:(int64_t)delta;

@end
