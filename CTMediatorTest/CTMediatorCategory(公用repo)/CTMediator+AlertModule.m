//
//  CTMediator+AlertModule.m
//
//  Created by mac on 2022/8/31.
//

#import "CTMediator+AlertModule.h"

NSString * const kAlertModule = @"AlertModule";

@implementation CTMediator (AlertModule)

- (void)showAlertMessage:(NSString *)message{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
        paramsToSend[@"duration"] = @(2.0);
    }
    [self performTarget:kAlertModule
                 action:@"promptMessage"
                 params:paramsToSend
      shouldCacheTarget:YES];
}
- (void)showAlertMessage:(NSString *)message atDuration:(NSInteger)duration{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (duration) {
        paramsToSend[@"duration"] = @(duration);
    }
    [self performTarget:kAlertModule
                 action:@"promptMessage"
                 params:paramsToSend
      shouldCacheTarget:YES];
}
// 转
- (void)showLoading{
    [self performTarget:kAlertModule
                 action:@"promptLoadingWithMessage"
                 params:nil
      shouldCacheTarget:YES];
}
- (void)showLoadingWithMessage:(NSString *)message{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    [self performTarget:kAlertModule
                 action:@"promptLoadingWithMessage"
                 params:paramsToSend
      shouldCacheTarget:YES];
}
// 动图
- (void)showLoadingWithGif{
    [self performTarget:kAlertModule
                 action:@"promptLoadingWithGif"
                 params:nil
      shouldCacheTarget:YES];
}
// 停止
- (void)stopAlert{
    [self performTarget:kAlertModule
                 action:@"stopPrompt"
                 params:nil
      shouldCacheTarget:YES];
}

@end
