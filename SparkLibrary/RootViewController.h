//
//  RootViewController.h
//  SparkLibrary
//
//  Created by Mohamed  Hegab on 8/19/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewController.h"
#import "ReaderController.h"
#import "MBProgressHUD.h"
#import <StoreKit/StoreKit.h>
#import "AdWhirlView.h"
#import "AdWhirlDelegateProtocol.h"


@interface RootViewController : UITableViewController <MBProgressHUDDelegate,SKRequestDelegate,AdWhirlDelegate>
{
    
  	AdWhirlView *awView;
    MBProgressHUD *HUD;
    NSString *pListPath;
   	NSMutableArray *categories;
    IBOutlet CellViewController * cellVC;
    ReaderController * readerController;
    UIBackgroundTaskIdentifier bgTask;

    
}
-(void)endOfGetData;
@property(nonatomic	,retain) AdWhirlView *awView;
@property (nonatomic, retain) NSMutableArray *categories;
@property (nonatomic,retain) ReaderController * readerController;

-(void)getProducts;
-(void)alertMessage;
-(void)getList;
-(void)checkAndCreatePList;
-(IBAction)myLibraryPage:(id)sender;
-(IBAction)aboutUsPage:(id)sender;
-(IBAction)description:(id)sender;


@end
