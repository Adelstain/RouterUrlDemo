//
//  UserInfoVC.m
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/31.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import "UserInfoVC.h"
#import "WeeDonMapVO.h"
#import "WeeDonRouter.h"
#import "UIViewController+Router.h"

@interface UserInfoVC ()

@end

@implementation UserInfoVC

+ (void)load{
    WeeDonMapVO *vo = [WeeDonMapVO new];
    vo.classname = NSStringFromClass(self);
    [[WeeDonRouter sharedInstance] registerWithMapVO:vo withKey:@"userInfo"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"王小胖个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 80, 40)];
    nameLabel.text = self.pramaDict[@"name"];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.backgroundColor = [UIColor lightGrayColor];
    nameLabel.textColor = [UIColor redColor];
    [self.view addSubview:nameLabel];
    
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 140, 80, 40)];
    weightLabel.text = self.pramaDict[@"weight"];
    weightLabel.textAlignment = NSTextAlignmentCenter;
    weightLabel.backgroundColor = [UIColor lightGrayColor];
    weightLabel.textColor = [UIColor redColor];
    [self.view addSubview:weightLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
