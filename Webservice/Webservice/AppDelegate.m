//
//  AppDelegate.m
//  Webservice
//
//  Created by Hanguang on 14-5-25.
//  Copyright (c) 2014年 com.kangge. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "loginViewController.h"
#import "userInfo.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    ViewController *mainViewController = [[ViewController alloc] init];
    self.window.rootViewController = mainViewController;
//    if ([[userInfo sharedObject].strUid length] == 0) {
//        // 初始化AFNetworking
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        
//        // 传递json格式参数
//        NSDictionary *parameters = @{@"mobile": @"15618989616",
//                                     @"pass": @"111111"};
//        
//        // 用manager post到网站
//        [manager POST:@"http://kongqueling.tupai.cc/api/dologin?"
//           parameters:parameters
//              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                  NSLog(@"JSON: loaded");//responseObject);
//                  
//                  // 生成NSDATA使用jsonkit转换传递过来的数据
//                  mainViewController.jsonDic = responseObject;
//                  [loginVC presentViewController:mainViewController animated:YES completion:nil];
//                  
//              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                  NSLog(@"Error: %@", error);
//              }];
//
//    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
