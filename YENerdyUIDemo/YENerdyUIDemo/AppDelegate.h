//
//  AppDelegate.h
//  YENerdyUIDemo
//
//  Created by yongen on 17/2/16.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

