//
//  RootViewController.h
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewController.h"
#import "PDFViewController.h"
#import "ReaderController.h"
#import "MBProgressHUD.h"

@interface RootViewController : UITableViewController <MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
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
-(IBAction)myLibraryPage:(id)sender;
-(IBAction)description:(id)sender;
 
@end
