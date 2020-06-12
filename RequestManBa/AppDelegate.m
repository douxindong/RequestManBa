//
//  AppDelegate.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [ViewController new];
    MainTabBarController *mainVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainVC;
    [self.window makeKeyAndVisible];
    
    
    
//    NSString *url = @"MiniProgram://lifevc.com/packages/main/live-room/index?liveId=428548&relatedGuangBusinessId=43762230&from=backstagePat&userName=gh_9648f422f2cd";
//    NSString *url1 = @"MiniProgram://lifevc.com?path=packages%2Fmain%2Flive-room%2Findex%3FliveId%3D428548%26relatedGuangBusinessId%3D43762230%26from%3DbackstagePath&userName=gh_9648f422f2cd";
//    NSURL *URL = [NSURL URLWithString:url];
//    NSURL *URL1 = [NSURL URLWithString:url1];
    
    
    
    
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
     if (self.window) {
         if (url) {
//             NSString *fileNameStr = [url lastPathComponent];
//             NSString *Doc = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/localFile"] stringByAppendingPathComponent:fileNameStr];
//             NSLog(@"Doc == %@",Doc);
//             NSData *data = [NSData dataWithContentsOfURL:url];
//             [data writeToFile:Doc atomically:YES];
         }
     }
     return YES;
}


@end
