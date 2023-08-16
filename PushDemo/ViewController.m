//
//  ViewController.m
//  PushDemo
//
//  Created by Lee on 2023/8/16.
//

#import "ViewController.h"
#import "SecondController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"哈哈哈";
    // Do any additional setup after loading the view.
}

- (IBAction)didClickedSecondButton:(UIButton *)sender {
    SecondController *controller = [[SecondController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
