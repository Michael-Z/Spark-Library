//
//  SparkLibraryAppDelegate.h
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;

@interface SparkLibraryAppDelegate : NSObject <UIApplicationDelegate>
{
    UIViewController *viewController;
    NSString *pListPath;
     Reachability* hostReach;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
-(void)getList;
-(void)checkAndCreatePList;

@end
