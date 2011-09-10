//
//	ReaderMainToolbar.m
//	Reader v2.1.0
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
#import "ReaderController.h"
#import "ReaderConstants.h"
#import "ReaderMainToolbar.h"

#import <MessageUI/MessageUI.h>

@implementation ReaderMainToolbar

#pragma mark Constants

#define TITLE_Y 8.0f
#define TITLE_X 12.0f
#define TITLE_HEIGHT 28.0f

#define DONE_BUTTON_WIDTH 56.0f
#define PRINT_BUTTON_WIDTH 44.0f
#define EMAIL_BUTTON_WIDTH 44.0f

#pragma mark Properties

@synthesize delegate;

#pragma mark ReaderMainToolbar instance methods

- (id)initWithFrame:(CGRect)frame
{
 	return [self initWithFrame:frame title:nil];
}

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
 
	if ((self = [super initWithFrame:frame]))
	{
		self.translucent = YES;
		self.barStyle = UIBarStyleBlack;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

		NSMutableArray *toolbarItems = [NSMutableArray new]; NSUInteger buttonCount = 0;

		CGFloat titleX = TITLE_X; CGFloat titleWidth = (self.bounds.size.width - (titleX * 2.0f));

#if (READER_STANDALONE == FALSE) // Option

		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"button")
										style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];

		[toolbarItems addObject:doneButton]; [doneButton release]; buttonCount++; titleX += DONE_BUTTON_WIDTH; titleWidth -= DONE_BUTTON_WIDTH;

#endif // end of READER_STANDALONE Option

		UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];

		[toolbarItems addObject:flexSpace]; [flexSpace release];

#if (READER_ENABLE_PRINT == TRUE) // Option

		Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");

		if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
		{
			UIBarButtonItem *printButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Reader-Print.png"]
											style:UIBarButtonItemStyleBordered target:self action:@selector(printButtonTapped:)];

			[toolbarItems addObject:printButton]; [printButton release]; buttonCount++; titleWidth -= PRINT_BUTTON_WIDTH;
		}

#endif // end of READER_ENABLE_PRINT Option

 //big font
        UIBarButtonItem *enlargeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"enlargeIcon.png"]
                                                                        style:UIBarButtonItemStyleBordered target:self action:@selector(fontButtonTapped:)];
        
        [toolbarItems addObject:enlargeButton]; [enlargeButton release]; buttonCount++; titleWidth -= PRINT_BUTTON_WIDTH;
		
        
        
        //end big font
      //bookmark icon
        UIBarButtonItem *bookmarkButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bookmark.png"]
                                                                          style:UIBarButtonItemStyleBordered target:self action:@selector(bookmarkTapped:)];
        
        [toolbarItems addObject:bookmarkButton]; [bookmarkButton release]; buttonCount++; titleWidth -= PRINT_BUTTON_WIDTH;
        //end of bookmark icon
        
        
        
        
		if (buttonCount > 0) [self setItems:toolbarItems animated:NO]; [toolbarItems release];

		CGRect titleRect = CGRectMake(titleX, TITLE_Y, titleWidth, TITLE_HEIGHT);

		theTitleLabel = [[UILabel alloc] initWithFrame:titleRect];

		theTitleLabel.text = title; // Toolbar title
		theTitleLabel.textAlignment = UITextAlignmentCenter;
		theTitleLabel.font = [UIFont systemFontOfSize:20.0f];
		theTitleLabel.textColor = [UIColor colorWithWhite:1.0f alpha:1.0f];
		theTitleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
		theTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		theTitleLabel.backgroundColor = [UIColor clearColor];
		theTitleLabel.adjustsFontSizeToFitWidth = YES;
		theTitleLabel.minimumFontSize = 14.0f;

	//	[self addSubview:theTitleLabel];
	}

	return self;
}

- (void)dealloc
{
 
	[theTitleLabel release], theTitleLabel = nil;

	[super dealloc];
}

- (void)setToolbarTitle:(NSString *)title
{
 
	theTitleLabel.text = title;
}

- (void)hideToolbar
{
 
	if (self.hidden == NO)
	{
		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void)
			{
				self.alpha = 0.0f;
			}
			completion:^(BOOL finished)
			{
				self.hidden = YES;
			}
		];
	}
}

- (void)showToolbar
{
 
	if (self.hidden == YES)
	{
		[UIView animateWithDuration:0.25 delay:0.0
			options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
			animations:^(void)
			{
				self.hidden = NO;
				self.alpha = 1.0f;
			}
			completion:NULL
		];
	}
}

#pragma mark UIBarButtonItem action methods

- (void)doneButtonTapped:(UIBarButtonItem *)button
{
 
	[delegate tappedInToolbar:self doneButton:button];
}


- (void)fontButtonTapped:(UIBarButtonItem *)button
{ 
	[delegate tappedInToolbar:self fontButton:button];
}


- (void)bookmarkTapped:(UIBarButtonItem *)button
{
 
	[delegate tappedInToolbar:self bookmarkButton:button];
}


- (void)printButtonTapped:(UIBarButtonItem *)button
{


	[delegate tappedInToolbar:self printButton:button];
}

- (void)emailButtonTapped:(UIBarButtonItem *)button
{


	[delegate tappedInToolbar:self emailButton:button];
}

@end
