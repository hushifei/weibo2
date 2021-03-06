//
//  XXRTabBarViewController.m
//  weibo2
//
//  Created by rgc on 15/8/11.
//  Copyright (c) 2015年 rgc. All rights reserved.
//

#import "XXRTabBarViewController.h"
#import "XXRHomeViewController.h"
#import "XXRDiscoverViewController.h"
#import "XXRMessageViewController.h"
#import "XXRMeViewController.h"

#import "XXRTabBar.h"

#import "UIImage+XXR.h"
#import "Common.h"

@interface XXRTabBarViewController ()
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) XXRTabBar *customTabBar; // 为什么使用weak？何时使用weak？
@end

@implementation XXRTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化TabBar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

/**
 * 初始化TabBar
 */
- (void)setupTabbar {
    XXRTabBar *customTabBar = [[XXRTabBar alloc] init];
    customTabBar.backgroundColor = [UIColor redColor];
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    
    self.customTabBar = customTabBar;
}

- (void)setupAllChildViewControllers {
    // 1.首页
    XXRHomeViewController *home = [[XXRHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    // 2.消息
    XXRMessageViewController *message = [[XXRMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    // 3.广场
    XXRDiscoverViewController *discover = [[XXRDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    // 4.我
    XXRMeViewController *me = [[XXRMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标名
 *  @param selectedImageName 选中图标名
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    // 1.设置控制器的属性
    childVc.title = title;
    //    home.tabBarItem.title = @"首页";
    //    home.navigationItem.title = @"首页";
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        // iOS7 取消TabBar图标渲染
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    
    // 2.包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}


@end
