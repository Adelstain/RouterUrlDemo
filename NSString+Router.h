//
//  NSString+Router.h
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/31.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Router)

+ (NSString *)getRouterUrlStringFromUrlString:(NSString *)urlString andParams:(NSDictionary *)params;

+ (NSString *)getRouterVCUrlStringFromUrlString:(NSString *)urlString andParams:(NSDictionary *)params;

@end
