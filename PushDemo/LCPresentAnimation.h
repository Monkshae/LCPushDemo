//
//  LCPresentAnimation.h
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import <Foundation/Foundation.h>
#import "LCCustomNavigationAnimationProtocol.h"

/// 模拟 presentController 动画
/// push 时下往上的位移动画，pop 时从上往下的位移动画
@interface LCPresentAnimation : NSObject <LCControllerAnimatedTransitioning>

// 当 needMask = YES 时，会一个透明 mask 将 fromVC 与 toVC 隔开。默认为 NO。
@property (nonatomic, assign) BOOL needMask;

@end

