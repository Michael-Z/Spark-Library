//
//	ReaderDemoController.h
//	Reader v2.0.0
//
//	Created by Julius Oklamcak on 2011-07-01.
//	Copyright © 2011 Julius Oklamcak. All rights reserved.
//
//	This work is being made available under a Creative Commons Attribution license:
//		«http://creativecommons.org/licenses/by/3.0/»
//	You are free to use this work and any derivatives of this work in personal and/or
//	commercial products and projects as long as the above copyright is maintained and
//	the original author is attributed.
//

#import <UIKit/UIKit.h>

#import "ReaderViewController.h"

@interface ReaderController : UIViewController <ReaderViewControllerDelegate>
{
@private // Instance variables
    NSString * fileName;
    IBOutlet UIButton *backButton;
    IBOutlet UIButton *tapButton;
    NSString *pListPath;
}
@property(nonatomic,retain) IBOutlet NSString * fileName;
@property(nonatomic,retain) IBOutlet UIButton *backButton;
@property(nonatomic,retain) IBOutlet UIButton *tapButton;
-(void) backToLibrary;
-(void)checkAndCreatePList;
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer;
- (void)reloadThePDF:(NSString *)theFileName;
@end
