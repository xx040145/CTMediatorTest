//
//  ViewController.m
//  CTMediatorTest
//
//  Created by xx040145 on 2023/7/4.
//

#import "ViewController.h"
#import "CTMediator.h"
#import "CTMediator+AlertModule.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(80, 100, 80, 44)];
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"调用alert" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor orangeColor].CGColor;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(callAlert) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callAlert{
    [[CTMediator sharedInstance] showAlertMessage:@"调用"];
}

@end
