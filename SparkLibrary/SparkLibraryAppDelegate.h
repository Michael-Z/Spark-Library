//
//  SparkLibraryAppDelegate.h
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFViewController.h"

@interface SparkLibraryAppDelegate : NSObject <UIApplicationDelegate>
{
    UIViewController *viewController;
	PDFViewController *pdfViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet PDFViewController *pdfViewController;
@end
