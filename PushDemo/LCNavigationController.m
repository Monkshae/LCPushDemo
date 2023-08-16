//
//  LCNavigationControllerViewController.m
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import "LCNavigationController.h"
#import "UIViewController+Push.h"
#import "LCPresentAnimation.h"
#import "LCCustomNavigationAnimationProtocol.h"

@interface LCNavigationController ()

@end

@implementation LCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
//    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush && [toVC conformsToProtocol:@protocol(LCCustomNavigationAnimationProtocol)]) {
        id<LCCustomNavigationAnimationProtocol> controller = (id<LCCustomNavigationAnimationProtocol>)toVC;
        id<LCControllerAnimatedTransitioning> animation = controller.navigationAnimation;
        animation.transitionType = operation;
        return animation;
    } else if (operation == UINavigationControllerOperationPop && [fromVC conformsToProtocol:@protocol(LCCustomNavigationAnimationProtocol)] ) {
        id<LCCustomNavigationAnimationProtocol> controller = (id<LCCustomNavigationAnimationProtocol>)fromVC;
        id<LCControllerAnimatedTransitioning> animation = controller.navigationAnimation;
        animation.transitionType = operation;
        return animation;
    }

    return nil;
}

// 依据supportedInterfaceOrientations文档，控制旋转的代码需要写在root view controller，或者全屏的presenting controller
// app的root view controller就是这个GMNavigationController，所以相关控制代码在这里。
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
