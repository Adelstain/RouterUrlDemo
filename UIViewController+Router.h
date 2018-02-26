//
//  UIViewController+Router.h
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/30.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeeDonMapVO;
@interface UIViewController (Router)
@property (nonatomic, strong) NSDictionary *pramaDict;
+ (instancetype)createWithMappingVO:(WeeDonMapVO *)aMappingVO extraData:(NSDictionary *)aParam;
@end
