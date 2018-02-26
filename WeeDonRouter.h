//
//  WeeDonRouter.h
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/30.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WeeDonMapVO;
@class UIViewController;

@interface WeeDonRouter : NSObject

@property (nonatomic,strong) NSMutableDictionary *mapDict;
@property (nonatomic,strong) UIViewController *rootVC;

+ (instancetype)sharedInstance;
//注册rootVC，到后面判断是push还是modal
- (void)registerRootVC:(UIViewController *)aRootVC;
//根据类名注册创建VC
- (void)registerWithMapVO:(WeeDonMapVO *)mapVO withKey:(NSString *)aKeyName;
//根据URL跳转
- (id)routerWithURL:(NSURL *)url;

@end
