//
//  MyLibraryViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewController.h"
#import "ReaderViewController.h"



@interface MyLibraryViewController : UITableViewController <ReaderViewControllerDelegate>
{
NSString *pListPath;
NSArray *categories;
IBOutlet CellViewController * cellVC;

}
 
@property (nonatomic, retain) NSArray *categories;

- (void)getList;
- (void)checkAndCreatePList;
- (void) showDocumentWithName:(NSString *)fileName;
- (void) dismissReaderViewController:(ReaderViewController *)viewController andShowDocumentWithName:(NSString *)fileName;


@end

@protocol MyLibraryViewControllerDelegate
- (void)myLibraryViewControllerDidFinish:(MyLibraryViewController *)controller;
@end