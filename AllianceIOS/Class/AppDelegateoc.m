/************************************************************
 *  * EaseMob CONFIDENTIAL
 * __________________
 * Copyright (C) 2013-2014 EaseMob Technologies. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of EaseMob Technologies.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from EaseMob Technologies.
 */

#import "AppDelegateoc.h"
#import "MainViewController.h"
#import "LoginViewController.h"

#import "AppDelegateoc+EaseMob.h"
#import "AppDelegateoc+UMeng.h"
#import "AppDelegateoc+Parse.h"


@interface AppDelegateoc ()

@end


@implementation AppDelegateoc

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _connectionState = eEMConnectionConnected;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:RGBACOLOR(60, 60, 60, 1)];
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(255, 255, 255, 1), NSForegroundColorAttributeName, [UIFont fontWithName:@ "HelveticaNeue-CondensedBlack" size:18.0], NSFontAttributeName, nil]];
    }
    
    // 环信UIdemo中有用到友盟统计crash，您的项目中不需要添加，可忽略此处。
    [self setupUMeng];

    // 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
    [self parseApplication:application didFinishLaunchingWithOptions:launchOptions];


    [self loginStateChange:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (_mainController) {
        [_mainController jumpToChatList];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}

#pragma mark - private
//登陆状态改变
-(void)loginStateChange:(NSNotification *)notification
{
    UINavigationController *nav = nil;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    BOOL isAutoLogin = [[[EaseMob sharedInstance] chatManager] isAutoLoginEnabled];
    BOOL loginSuccess = [notification.object boolValue];
    
    if (isAutoLogin || loginSuccess) {//登陆成功加载主窗口控制器
        //加载申请通知的数据
        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
        if (_mainController == nil) {
            _mainController = [[MainViewController alloc] init];
            [_mainController networkChanged:_connectionState];
            nav = [[UINavigationController alloc] initWithRootViewController:_mainController];
        }else{
            nav  = _mainController.navigationController;
        }
        
        // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
        [self initParse];
    }else{//登陆失败加载登陆页面控制器
        _mainController = nil;
        LoginViewController *loginController = [[LoginViewController alloc] init];
        nav = [[UINavigationController alloc] initWithRootViewController:loginController];
        loginController.title = NSLocalizedString(@"AppName", @"EaseMobDemo");
        
        // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处。
        [self clearParse];
    }
    
    //设置7.0以下的导航栏
    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
        nav.navigationBar.barStyle = UIBarStyleDefault;
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
                                forBarMetrics:UIBarMetricsDefault];
        
        [nav.navigationBar.layer setMasksToBounds:YES];
    }
    
    nav.navigationBar.translucent  =NO;
    
    self.window.rootViewController = nav;
    
    [nav setNavigationBarHidden:YES];
    [nav setNavigationBarHidden:NO];
}

@end
