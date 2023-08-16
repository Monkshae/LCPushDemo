//
//  UIViewController+Push.h
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMTransitioningMask: UIView

@end

@interface UIViewController (Push)

/// 与 needMask 属性配合使用。当 needMask = YES 时，_mask 将会展示在 fromVC 与 toVC 层级的中间。默认不展示。
@property (nonatomic, strong) UIView *mask;
/// 截图
@property (nonatomic, strong) UIView *snapshot;

/// 用来替代popToRootViewControllerAnimated，在支持自定义present转场动画调用
- (void)popToRootViewController;

@end
NS_ASSUME_NONNULL_END
