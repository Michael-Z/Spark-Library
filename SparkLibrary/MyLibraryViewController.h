//
//  MyLibraryViewController.h
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewController.h"
#import "PDFViewController.h"
#import "ReaderController.h"

@interface MyLibraryViewController : UITableViewController
{
NSString *pListPath;
NSArray *categories;
IBOutlet CellViewController * cellVC;
PDFViewController *pdfViewController; 
ReaderController * readerController;

}
@property (nonatomic, retain) NSArray *categories;
@property (nonatomic,retain) PDFViewController * pdfViewController;
@property (nonatomic,retain) ReaderController * readerController;
-(void)getList;
-(void)checkAndCreatePList;

@end
