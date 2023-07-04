//
//  Target_AlertModule.h
//
//  Created by mac on 2022/8/31.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface Target_AlertModule : NSObject<MBProgressHUDDelegate>

// 类似toast弹出消息
- (void)Action_promptMessage:(NSDictionary *)params;

// 转
- (void)Action_promptLoadingWithMessage:(NSDictionary *)params;

// 动图
- (void)Action_promptLoadingWithGif:(NSDictionary *)params;

// 隐藏
- (void)Action_stopPrompt:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
