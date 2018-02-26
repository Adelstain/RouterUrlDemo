//
//  UIViewController+Router.m
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/30.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import "UIViewController+Router.h"
#import "WeeDonMapVO.h"
#import "WeeDonRouter.h"
#import <objc/runtime.h>

static const char *key = "pramaDict";
@implementation UIViewController (Router)

- (void)setPramaDict:(NSDictionary *)pramaDict{
    objc_setAssociatedObject(self, key, pramaDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id)pramaDict{
    return objc_getAssociatedObject(self, key);
}

+ (instancetype)createWithMappingVOKey:(NSString *)aKey extraData:(NSDictionary *)aParam
{
    return [self createWithMappingVO:[WeeDonRouter sharedInstance].mapDict[aKey] extraData:aParam];
}

+ (instancetype)createWithMappingVO:(WeeDonMapVO *)aMappingVO extraData:(NSDictionary *)aParam
{
    if (aMappingVO.classname == nil) {
        NSLog(@"OTSMappingVO error %@, className is nil",aMappingVO.description);
        return nil;
    }
    
    Class class = NSClassFromString(aMappingVO.classname);
    if (!class) {
        NSLog(@"OTSMappingVO error %@, no such class",aMappingVO);
        return nil;
    }
    
    UIViewController *vc = [[class alloc] initWithNibName:nil bundle:nil];
    aParam = aParam ?: @{};
    vc.pramaDict = aParam;
    
    return vc;
}


@end
