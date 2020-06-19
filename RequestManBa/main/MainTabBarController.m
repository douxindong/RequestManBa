//
//  MainTabBarController.m
//  RequestManBa
//
//  Created by lifevc on 2020/6/11.
//  Copyright © 2020 maba. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HistoryViewController.h"
#import "FileListViewController.h"
#import "CollectionsViewController.h"
#import "SettingViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FileListViewController *historyVC = [FileListViewController new];
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
    historyVC.tabBarItem = item1;
    MainNavigationController *historyNav = [[MainNavigationController alloc] initWithRootViewController:historyVC];
    [self addChildViewController:historyNav];
    
    CollectionsViewController *collectionsVC = [CollectionsViewController new];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:0];
    collectionsVC.tabBarItem = item2;
    MainNavigationController *collectionsNav = [[MainNavigationController alloc] initWithRootViewController:collectionsVC];
    [self addChildViewController:collectionsNav];
    
    SettingViewController *settingVC = [SettingViewController new];
    UITabBarItem *item3 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemContacts tag:0];
    settingVC.tabBarItem = item3;
    MainNavigationController *settingNav = [[MainNavigationController alloc] initWithRootViewController:settingVC];
    [self addChildViewController:settingNav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
