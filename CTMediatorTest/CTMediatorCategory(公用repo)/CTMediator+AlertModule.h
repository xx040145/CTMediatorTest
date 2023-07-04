//
//  CTMediator+AlertModule.h
//
//  Created by mac on 2022/8/31.
//  开放给公共

#import "CTMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTMediator (AlertModule)

//toast
- (void)showAlertMessage:(NSString *)message;
- (void)showAlertMessage:(NSString *)message atDuration:(NSInteger)duration;
// 转
- (void)showLoading;
- (void)showLoadingWithMessage:(NSString *)message;
// 动图
- (void)showLoadingWithGif;
// 停止
- (void)stopAlert;


@end

NS_ASSUME_NONNULL_END
