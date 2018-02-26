//
//  ViewController.m
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/30.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import "ViewController.h"
#import "WeeDonRouter.h"
#import "NSString+Router.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOSRouterDemo";
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.view.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn setFrame:CGRectMake(80, 100, 60, 40)];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(router) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)router{
    NSMutableDictionary *pramaDict = [NSMutableDictionary dictionary];
    pramaDict[@"name"] = @"王小胖";
    pramaDict[@"weight"] = @"280kg";
    [[WeeDonRouter sharedInstance] routerWithURL:[NSURL URLWithString:[NSString getRouterVCUrlStringFromUrlString:@"userInfo"  andParams:pramaDict]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
