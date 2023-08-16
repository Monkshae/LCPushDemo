//
//  ThirdController.m
//  ForLayout
//
//  Created by Lee on 2023/8/1.
//

#import "ThirdController.h"
#import "LCPresentAnimation.h"
#import "UIViewController+Push.h"

@interface ThirdController ()<LCCustomNavigationAnimationProtocol>

@end

@implementation ThirdController

@synthesize navigationAnimation;

- (instancetype)init {
    self = [super init];
    if (self) {
        LCPresentAnimation *navigationAnimation = [LCPresentAnimation new];
        navigationAnimation.needMask = YES;
        self.navigationAnimation = navigationAnimation;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.greenColor;
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(150, 200, 100, 200);
    [btn setTitle:@"返回首页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didButtonClicked:(UIButton *)btn {
    [self popToRootViewController];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
