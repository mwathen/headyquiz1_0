//
//  HeadyQuizAppDelegate.h
//  test
//
//  Created by Michael Wathen on 12/28/12.
//  Copyright (c) 2012 Michael Wathen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadyQuizViewController.h"
#import <CoreData/CoreData.h>

@class HeadyQuizViewController;

@interface HeadyQuizAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate> {
    HeadyQuizViewController  *view;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HeadyQuizViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
