//
//  locaWebViewFromLoadAppDelegate.h
//  locaWebViewFromLoad
//
//  Created by azu on 11/08/05.
//  Copyright 2011 azu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class locaWebViewFromLoadViewController;

@interface locaWebViewFromLoadAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet locaWebViewFromLoadViewController *viewController;

@end
