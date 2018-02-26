//
//  NSString+Router.m
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/31.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import "NSString+Router.h"

@implementation NSString (Router)

+ (NSString *)getRouterUrlStringFromUrlString:(NSString *)urlString andParams:(NSDictionary *)params
{
    NSString *json = nil;
    if ([NSJSONSerialization isValidJSONObject:(NSDictionary *)params]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        if (!error) {
            json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        else {
            NSLog(@"error convert to json,%@,%@",error,params);
        }
    }
    
    if (!json) {
        return urlString;
    }
    
    NSString *jsonString = [urlString stringByAppendingFormat:@"?body=%@",json];
    jsonString = [jsonString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (NSString *)getRouterVCUrlStringFromUrlString:(NSString *)urlString andParams:(NSDictionary *)params
{
    return [self getRouterUrlStringFromUrlString:[NSString stringWithFormat:@"xiaoer://%@",urlString] andParams:params];
}


@end
