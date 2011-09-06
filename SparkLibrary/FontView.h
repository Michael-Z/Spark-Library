//
//  FontView.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLibraryViewController.h"

/*@protocol ReaderMainToolbarDelegate <NSObject>

@required // Delegate protocols

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar pdf2Button:(UIBarButtonItem *)button;
 
@end
*/
@class ReaderViewController;

@interface FontView : UIViewController
{
    NSString *pListPath;
    MyLibraryViewController *myLibraryViewController;
    ReaderViewController *readerController;
}

@property(nonatomic, assign) MyLibraryViewController *myLibraryViewController;
@property(nonatomic, assign) ReaderViewController *readerController;

-(IBAction)getPDF1:(id)sender;
-(IBAction)getPDF2:(id)sender;
-(void)checkAndCreatePList;

@end

