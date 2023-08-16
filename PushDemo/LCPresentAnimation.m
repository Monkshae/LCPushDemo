//
//  LCPresentAnimation.m
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import "LCPresentAnimation.h"
#import "UIViewController+Push.h"

@interface LCPresentAnimation ()

@property(nonatomic, assign) NSTimeInterval duration;

@end

@implementation LCPresentAnimation
@synthesize transitionType;

- (instancetype)init {
    if (self = [super init]) {
        self.duration = 0.3;
        self.needMask = NO;
    }
    return self;
}

- (void)push:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    // 在containerView上加一个toVC.snapshot，把之前页面当作背景
    // 不加的话，toView在动画结束时会被系统移除，进而底部背景会突然变白
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.snapshot.frame = bounds;
    [[transitionContext containerView] addSubview:fromVC.snapshot];
    
    // 添加一个半透明的蒙层，展示在 from view 下面
    if (self.needMask) {
        [[transitionContext containerView] addSubview:fromVC.mask];
    }

    // 系统不会为我们自动添加 toView，所以我们需要自己添加，以保证 toView 的页面及动画正常展示
    [[transitionContext containerView] addSubview:toView];

    // 先将toView放置在屏幕下边，为下一步的平移动画做准备
    CGRect newFrame = toView.frame;
    newFrame.origin.y = CGRectGetHeight(bounds);
    toView.frame = newFrame;

    // 从下到上的平移动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toView.frame = bounds;
        fromVC.mask.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}


- (void)pop:(id<UIViewControllerContextTransitioning>)transitionContext {
    CGRect bound = [[UIScreen mainScreen] bounds];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];

    // 将toView加到toVC.snapshot 的的下面。
    // 不加的话，动画结束后看不到 toView
    // 动画过程中看到的是toVC.snapshot
    // 并且需要将 toView放到toVC.snapshot的下面，确保view层级正确
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] insertSubview:toView belowSubview:toVC.snapshot];
    // 必须把先前的 mask view 拿出来，显示的标记为 alpha = 1，要不然会发现该蒙层是突然消失
    // 经打断点发现，其 alpha 此时为0，所以必须要设置一下 alpha = 1
    toVC.mask.alpha = 1;
    
    NSArray * a = transitionContext.containerView.subviews;
    CGRect newFrame = fromView.frame;
    newFrame.origin.y = CGRectGetHeight(bound);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = newFrame;
        toVC.mask.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.needMask) {
            [toVC.mask removeFromSuperview];
        }
        // 动画结束后移除toVC.snapshot，留着会挡住toVC，用户无法交互
        [toVC.snapshot removeFromSuperview];
        // 需要将toVC.snapshot清空，下一次弹窗时再重新生成 snapshot，确保每一次 snapshot 为最新画面
        toVC.snapshot = nil;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
     }];
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    if (self.transitionType == UINavigationControllerOperationPush) {
        [self push:transitionContext];
    } else if (self.transitionType == UINavigationControllerOperationPop) {
        [self pop:transitionContext];
    }
}

@end

