//
//  PDFViewController.h
//  Leaves
//
//  Created by Tom Brow on 4/19/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesViewController.h"

@interface PDFViewController : LeavesViewController <UISearchBarDelegate, UITableViewDelegate> {
	CGPDFDocumentRef pdf;
	
	IBOutlet UIWebView *documentLayout;
  NSString *pListPath;
    IBOutlet UILabel *pageNo;
    IBOutlet UIButton *backButton;
    NSString * fileName;
	}
 
@property(nonatomic,retain) UILabel *pageNo;
@property(nonatomic,retain)  UIButton *backButton;
@property(nonatomic, retain) IBOutlet UIWebView *documentLayout;
@property(nonatomic,retain) IBOutlet NSString * fileName;
  
@end
