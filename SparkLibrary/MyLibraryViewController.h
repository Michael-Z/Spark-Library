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
#import "ReaderViewController.h"

@interface MyLibraryViewController : UITableViewController <ReaderViewControllerDelegate>
{
NSString *pListPath;
NSArray *categories;
IBOutlet CellViewController * cellVC;
PDFViewController *pdfViewController; 

}

@property (nonatomic, retain) NSArray *categories;
@property (nonatomic,retain) PDFViewController * pdfViewController;

-(void)getList;
-(void)checkAndCreatePList;
- (void) showDocumentWithName:(NSString *)fileName;


@end
