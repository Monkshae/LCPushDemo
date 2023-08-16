//
//  LCCustomNavigationAnimationProtocol.h
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import <UIKit/UIKit.h>

/// 通过此协议来约束所有自定义 navigation 动画类的行为。
@protocol LCControllerAnimatedTransitioning <UIViewControllerAnimatedTransitioning>

/// 自定义 navigation 动画类需要知道某一时刻是 push还是pop。
@property(nonatomic, assign) UINavigationControllerOperation transitionType;

@end

/// 对于想要使用自定义 push、pop 动画的 controller，需要实现该协议。
/// GMNavigationController 会检查 controller 是否实现该协议以决定是否要使用自定义动画
/// 该协议要求controller 需要实现一个属性，
/// 并且要求该属性也需要实现一个协议：GMControllerAnimatedTransitioning。
/// 该属于会用在 GMNavigationController中，具体逻辑请自行查找。
/// 下面有一个 Demo
@protocol LCCustomNavigationAnimationProtocol <NSObject>

@property (nonatomic, strong) id<LCControllerAnimatedTransitioning> navigationAnimation;

@end



/* Demo

// 挂载协议
@interface GMController () <GMCustomNavigationAnimationProtocol>
@end

@implementation GMController

// 使用synthesize确保协议中要求的属性有正确的 set 和 get 方法
@synthesize navigationAnimation;

- (void)initController {
    [super initController];

    // 为协议中要求的属性赋值
    GMPresentAnimation *navigationAnimation = [GMPresentAnimation new];
    navigationAnimation.needMask = YES;
    self.navigationAnimation = navigationAnimation;
}
*/
