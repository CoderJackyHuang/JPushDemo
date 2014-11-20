//
//  AppDelegate.m
//  JPushDemo
//
//  Created by 黄仪标 on 14/11/20.
//  Copyright (c) 2014年 黄仪标. All rights reserved.
//

#import "AppDelegate.h"
#import "JPushHelper/HYBJPushHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  
  [HYBJPushHelper setupWithOptions:launchOptions];
  
  self.window.backgroundColor = [UIColor whiteColor];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [HYBJPushHelper registerDeviceToken:deviceToken];
  return;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
  [HYBJPushHelper handleRemoteNotification:userInfo completion:nil];
  return;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
// ios7.0以后才有此功能
- (void)application:(UIApplication *)application didReceiveRemoteNotification
                   :(NSDictionary *)userInfo fetchCompletionHandler
                   :(void (^)(UIBackgroundFetchResult))completionHandler {
  [HYBJPushHelper handleRemoteNotification:userInfo completion:completionHandler];
  
  // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
  if (application.applicationState == UIApplicationStateActive) {
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                   message:userInfo[@"aps"][@"alert"]
                                                  delegate:nil
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定", nil];
    [alert show];
  }
  return;
}
#endif

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
  [HYBJPushHelper showLocalNotificationAtFront:notification];
  return;
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
  NSLog(@"Error in registration. Error: %@", err);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [application setApplicationIconBadgeNumber:0];
  return;
}

@end
