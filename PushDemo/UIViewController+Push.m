//
//  UIViewController+Push.m
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import "UIViewController+Push.h"
#import <objc/runtime.h>
#import "LCCustomNavigationAnimationProtocol.h"

@implementation SMTransitioningMask

@end

@implementation UIViewController (PushType)

- (SMTransitioningMask *)mask {
    SMTransitioningMask *mask = objc_getAssociatedObject(self,@selector(mask));
    if (!mask) {
        mask = [[SMTransitioningMask alloc] initWithFrame:[UIScreen mainScreen].bounds];
        mask.backgroundColor = [UIColor colorWithWhite:0 alpha:0.64];
        mask.alpha = 0;
        [self setMask:mask];
    }
    return mask;
}

- (void)setMask:(UIView *)mask {
    objc_setAssociatedObject(self, @selector(mask), mask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)snapshot {
    UIView *view = objc_getAssociatedObject(self, @selector(snapshot));
    if (!view) {
        view = [self.navigationController.view snapshotViewAfterScreenUpdates:NO];
        [self setSnapshot:view];
    }
    return view;
}

- (void)setSnapshot:(UIView *)snapshot {
    objc_setAssociatedObject(self, @selector(snapshot), snapshot, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)popToRootViewController {
    [self removeAllMaskAndSnapshot];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)removeAllMaskAndSnapshot {
    NSInteger count = self.navigationController.viewControllers.count;
    if (count < 2) {
        return;
    }
    for (NSInteger i = count - 2; i > 0; i--) {
        UIViewController *viewController = self.navigationController.viewControllers[i];
        // 找到需要删除的截图并删除
         [viewController.snapshot removeFromSuperview];
        [viewController.mask removeFromSuperview];
    }
}

@end
