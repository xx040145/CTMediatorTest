//
//  Target_AlertModule.m
//
//  Created by mac on 2022/8/31.
//

#import "Target_AlertModule.h"

@interface Target_AlertModule()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIWindow *windowPrompt;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation Target_AlertModule

// 类似toast弹出消息
- (void)Action_promptMessage:(NSDictionary *)params {
    NSString *msg = [params objectForKey:@"message"];
    float duration = 2.0;
    if ([params objectForKey:@"duration"]) {
        duration = [[params objectForKey:@"duration"] floatValue];
    }
    //getFrame
    CGRect rect = [self getShowFrame];
    
    //show
    self.windowPrompt = [[UIWindow alloc] initWithFrame:rect];
    self.windowPrompt.windowLevel = UIWindowLevelStatusBar;
    self.windowPrompt.hidden = NO;
    
    //横屏处理
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft){
        CGAffineTransform rotation = CGAffineTransformMakeRotation(3*M_PI/2);
        [self.windowPrompt setTransform:rotation];
    }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
        [self.windowPrompt setTransform:rotation];
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.windowPrompt animated:NO];
    //configure
    self.hud.mode = MBProgressHUDModeText;
    self.hud.bezelView.alpha = 0.8;
    self.hud.bezelView.layer.cornerRadius = 12;
    self.hud.detailsLabel.font = [UIFont systemFontOfSize:16];
//    hud.detailsLabel.textColor = [UIColor whiteColor];
    self.hud.detailsLabel.text = msg;
    self.hud.offset = CGPointMake(0, 150);
    
    //duration-Timer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(Action_stopPrompt) userInfo:nil repeats:NO];
}

// 转
- (void)Action_promptLoadingWithMessage:(NSDictionary *)params {
    NSString *msg = [params objectForKey:@"message"];
    //getFrame
    CGRect rect = [self getShowFrame];
    
    //show
    self.windowPrompt = [[UIWindow alloc] initWithFrame:rect];
    self.windowPrompt.windowLevel = UIWindowLevelStatusBar;
    self.windowPrompt.hidden = NO;
    
    //横屏处理
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft){
        CGAffineTransform rotation = CGAffineTransformMakeRotation(3*M_PI/2);
        [self.windowPrompt setTransform:rotation];
    }else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight){
        CGAffineTransform rotation = CGAffineTransformMakeRotation(M_PI/2);
        [self.windowPrompt setTransform:rotation];
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.windowPrompt animated:NO];
    //configure
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.bezelView.alpha = 0.8;
    self.hud.bezelView.layer.cornerRadius = 12;
    self.hud.detailsLabel.font = [UIFont systemFontOfSize:16];
    self.hud.detailsLabel.text = msg;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(Action_stopPrompt) userInfo:nil repeats:NO];
}

// 动图
- (void)Action_promptLoadingWithGif:(NSDictionary *)params{
    NSData *imageData;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"load" ofType:@"gif"];
    imageData = [NSData dataWithContentsOfFile:filePath];
    //getFrame
    CGRect rect = [self getShowFrame];
    
    //show
    self.windowPrompt = [[UIWindow alloc] initWithFrame:rect];
    self.windowPrompt.windowLevel = UIWindowLevelStatusBar;
    self.windowPrompt.hidden = NO;
    self.hud = [MBProgressHUD showHUDAddedTo:self.windowPrompt animated:NO];
    
    //gif图片
    UIImage *image = [UIImage sd_animatedGIFWithData:imageData];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    //configure
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.backgroundColor = [UIColor clearColor];
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.customView = imageView;
    self.hud.bezelView.backgroundColor = [UIColor clearColor];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(Action_stopPrompt) userInfo:nil repeats:NO];
}

// 隐藏
- (void)Action_stopPrompt:(NSDictionary *)params{
    [self Action_stopPrompt];
}
- (void)Action_stopPrompt{
    if (self.hud != nil) {
        __weak typeof (self)weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.hud removeFromSuperview];
            weakSelf.hud = nil;
            weakSelf.windowPrompt.hidden = NO;
            weakSelf.windowPrompt = nil;
            [weakSelf.timer invalidate];
            weakSelf.timer = nil;
        });
    }
}

- (CGRect)getShowFrame{
    UIViewController *vc = [self getCurrentShowViewController];
    CGRect rec1 = vc.view.frame;
    
    return rec1;
}
/** 递归查找当前显示的VC*/
- (UIViewController *)recursiveFindCurrentShowViewControllerFromViewController:(UIViewController *)fromVC{
    if ([fromVC isKindOfClass:[UINavigationController class]]) {
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UINavigationController *)fromVC) visibleViewController]];
    } else if ([fromVC isKindOfClass:[UITabBarController class]]) {
        return [self recursiveFindCurrentShowViewControllerFromViewController:[((UITabBarController *)fromVC) selectedViewController]];
    } else {
        if (fromVC.presentedViewController) {
            return [self recursiveFindCurrentShowViewControllerFromViewController:fromVC.presentedViewController];
        } else {
            return fromVC;
        }
    }
}
/** 查找当前显示的ViewController*/
- (UIViewController *)getCurrentShowViewController{
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowVC = [self recursiveFindCurrentShowViewControllerFromViewController:rootVC];
    return currentShowVC;
}

@end
