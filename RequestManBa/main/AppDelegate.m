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
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory == %@",documentsDirectory);
//    [self showFilesWithURL:[NSURL fileURLWithPath:documentsDirectory]];
    
    
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
- (BOOL)showFilesWithURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES] forKey: NSURLIsExcludedFromBackupKey error: &error];
    if (!success) {
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


@end
