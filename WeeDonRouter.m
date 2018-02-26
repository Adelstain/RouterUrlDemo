//
//  WeeDonRouter.m
//  RouterUrlDemo
//
//  Created by fengweidong on 2017/8/30.
//  Copyright © 2017年 fengweidong. All rights reserved.
//

#import "WeeDonRouter.h"
#import "WeeDonMapVO.h"
#import "UIViewController+Router.h"

@interface WeeDonRouter()

@end

@implementation WeeDonRouter

+ (instancetype)sharedInstance{
    static WeeDonRouter *router = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        router = [WeeDonRouter new];
    });
    return router;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.mapDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)registerWithMapVO:(WeeDonMapVO *)mapVO withKey:(NSString *)aKeyName{
    aKeyName = [aKeyName lowercaseString];
    if (self.mapDict[aKeyName]) {
        NSLog(@"overwrite router vo key[%@], mapping vo,%@", aKeyName, self.mapDict[aKeyName]);
    }
    self.mapDict[aKeyName] = mapVO;
}

- (id)routerWithURL:(NSURL *)url{
    if (!url) {
        NSLog(@"router error url");
        return nil;
    }
    
    NSString *scheme = url.scheme;
    NSString *host = [url.host lowercaseString];
    NSString *query = url.query;
    NSMutableDictionary *params = ((NSDictionary *)([self getDictFromJsonString:query][@"body"])).mutableCopy;
    
    if ([scheme isEqualToString:@"xiaoer"]) {
        return [self routeVCWithHost:host params:params];
    } else if ([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"]) {
//        return [self routeWebWithUrl:aUrl];
        return nil;
    } else {
        NSLog(@"is not a router url,%@", url.absoluteString.stringByRemovingPercentEncoding);
        return nil;
    }
}

- (id)routeVCWithHost:(NSString *)aHost params:(NSDictionary *)aParams
{
    if (!aHost) {
        return nil;
    }
     __block id mapVO;
    [self.mapDict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *tempKey = key;
        if ([tempKey compare:aHost options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            mapVO = obj;
            *stop = YES;
        }
    }];
    
    WeeDonMapVO *mappingVO = (WeeDonMapVO *)mapVO;
    
    if (mappingVO == nil) {
        return nil;
    }
    
    return [self routeVCWithMappingVO:mappingVO params:aParams];
}

- (id)routeVCWithMappingVO:(WeeDonMapVO *)aVO params:(NSDictionary *)aParams
{
    UIViewController *vc = [UIViewController createWithMappingVO:aVO extraData:aParams];
    if (!vc) {
        NSLog(@"router error %@, can not new one",aVO);
        return nil;
    }
    
    if ([vc isKindOfClass:[UINavigationController class]]) {
        NSLog(@"cannot push a nc");
        return nil;
    }
    
    //Push VC
    if ([self.rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tbc = (id)self.rootVC;
        UIViewController *selectedVC = tbc.selectedViewController;
        if ([selectedVC isKindOfClass:[UINavigationController class]]
            ) {
            [(UINavigationController *)selectedVC pushViewController:vc animated:YES];
            
        } else {
            NSLog(@"没有导航怎么push?");
        }
    } else if ([self.rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (id)self.rootVC;
        if (nc == vc.navigationController) {
            [nc pushViewController:vc animated:YES];
        }else if (vc.navigationController){
            [vc.navigationController pushViewController:vc animated:YES];
        }else{
            [nc pushViewController:vc animated:YES];
        }
    } else {
        NSLog(@"rootvc is not a nc or tc, cannot push");
    }
    
    return @[vc];
}


- (NSDictionary *)getDictFromJsonString:(NSString *)aJsonString{
    //urldecode
    NSString *jsonString = [aJsonString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    NSArray *subStrings = [jsonString componentsSeparatedByString:@"="];
    if ([@"body" isEqualToString:subStrings[0]]) {
        if (subStrings[1]) {
            NSRange endCharRange = [jsonString rangeOfString:@"}" options:NSBackwardsSearch];
            if (endCharRange.location != NSNotFound) {
                jsonString = [jsonString substringToIndex:endCharRange.location+1];
            }
            NSRange range = [jsonString rangeOfString:@"="];
            //除去body＝剩下纯json格式string
            NSString *jsonStr = [jsonString substringFromIndex:range.location+1];
            
            if ([[jsonStr substringFromIndex:(jsonStr.length -1)] isEqualToString:@"\""]) { // 去掉末尾"号
                jsonStr = [jsonStr substringToIndex:(jsonStr.length-1)];
            }
            
            NSDictionary *resultDict = [self dictFromString:jsonStr];
            dict[@"body"] = resultDict;
        }
    }

    [dict.copy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            dict[key] = [obj stringValue];
        }
    }];

    if  (!dict[@"body"])
    dict[@"body"] = @{};
    return dict;
}

- (NSDictionary *)dictFromString:(NSString *)aString{
    if (aString == nil) {
        return nil;
    }
    
    NSData *theData = [aString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSError *error = nil;
    
    NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:theData options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"error convert json string to dict,%@,%@", aString, error);
        return nil;
    }
    else {
        return resultDict;
    }
}

- (void)registerRootVC:(UIViewController *)aRootVC
{
    if (self.rootVC) {
        NSLog(@"已经设置了rootvc，不能重复设置");
        return ;
    }
    self.rootVC = aRootVC;
}
@end
