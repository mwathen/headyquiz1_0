//
//  WhereamiAppDelegate.h
//  test
//
//  Created by Michael Wathen on 12/28/12.
//  Copyright (c) 2012 Michael Wathen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhereamiViewController.h"

@class WhereamiViewController;

@interface WhereamiAppDelegate : UIResponder <UIApplicationDelegate, UIScrollViewDelegate> {
    WhereamiViewController  *view;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WhereamiViewController *viewController;

@end
