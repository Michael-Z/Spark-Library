//
//	ReaderViewController.m
//	Reader v2.1.1
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

#import "ReaderConstants.h"
#import "ReaderScrollView.h"
#import "MyLibraryViewController.h"

@implementation ReaderViewController
@synthesize bookMarkDone;
bool enlargeFont = FALSE;
int zoom =0;
NSMutableDictionary* plistDict;


#pragma mark Constants

#define PAGING_VIEWS 3

#define TOOLBAR_HEIGHT 44.0f

#define PAGING_AREA_WIDTH 48.0f

#pragma mark Properties

@synthesize delegate;
@synthesize myLibraryViewController;

#pragma mark Support methods

- (void)updateScrollViewContentSize
{

    
	NSInteger count = [document.pageCount integerValue];
    
	if (count > PAGING_VIEWS) count = PAGING_VIEWS; // Limit
    
	CGFloat contentHeight = theScrollView.bounds.size.height;
    
	CGFloat contentWidth = (theScrollView.bounds.size.width * count);
    
	theScrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
}

- (void)updateScrollViewContentViews
{

    
	[self updateScrollViewContentSize]; // Update the content size
    
	NSMutableIndexSet *pageSet = [[NSMutableIndexSet new] autorelease];
    
	[contentViews enumerateKeysAndObjectsUsingBlock: // Enumerate content views
     ^(id key, id object, BOOL *stop)
     {
         ReaderContentView *contentView = object;
         
         [pageSet addIndex:contentView.tag];
     }
     ];
    
	__block CGRect viewRect = CGRectZero; viewRect.size = theScrollView.bounds.size;
    
	__block CGPoint contentOffset = CGPointZero; NSInteger page = [document.pageNumber integerValue];
    
	[pageSet enumerateIndexesWithOptions:NSEnumerationReverse usingBlock: // Enumerate page number set
     ^(NSUInteger number, BOOL *stop)
     {
         NSNumber *key = [NSNumber numberWithInteger:number]; // # key
         
         ReaderContentView *contentView = [contentViews objectForKey:key];
         
         contentView.frame = viewRect; if (page == number) contentOffset = viewRect.origin;
         
         viewRect.origin.x += viewRect.size.width; // Next view frame position
     }
     ];
    
	if (CGPointEqualToPoint(theScrollView.contentOffset, contentOffset) == false)
	{
		theScrollView.contentOffset = contentOffset; // Update content offset
	}
}

- (void)showDocumentPage:(NSInteger)page
{

	if (page != currentPage) // Only if different
	{
		NSInteger minValue; NSInteger maxValue;
		NSInteger maxPage = [document.pageCount integerValue];
		NSInteger minPage = 1;
        
		if ((page < minPage) || (page > maxPage)) return;
        
		if (maxPage <= PAGING_VIEWS) // Few pages
		{
			minValue = minPage;
			maxValue = maxPage;
		}
		else // Handle more pages
		{
			minValue = (page - 1);
			maxValue = (page + 1);
            
			if (minValue < minPage)
            {minValue++; maxValue++;}
			else
				if (maxValue > maxPage)
                {minValue--; maxValue--;}
		}
        
		CGRect viewRect = CGRectZero; viewRect.size = theScrollView.bounds.size;
        
		NSMutableDictionary *unusedViews = [[contentViews mutableCopy] autorelease];
        
		for (NSInteger number = maxValue; number >= minValue; number--)
		{
			NSNumber *key = [NSNumber numberWithInteger:number]; // # key
            
			ReaderContentView *contentView = [contentViews objectForKey:key];
            
			if (contentView == nil) // Create brand new content view
			{
				NSURL *fileURL = document.fileURL; NSString *phrase = document.password; // Document properties
                
				contentView = [[ReaderContentView alloc] initWithFrame:viewRect fileURL:fileURL page:number password:phrase];
                
				[theScrollView addSubview:contentView]; [contentViews setObject:contentView forKey:key];
                
				contentView.delegate = self; [contentView release];
			}
			else // Reposition the existing content view
			{
				contentView.frame = viewRect; [contentView zoomReset];
                
				[unusedViews removeObjectForKey:key];
			}
            
			viewRect.origin.x += viewRect.size.width;
		}
        
		[unusedViews enumerateKeysAndObjectsUsingBlock: // Remove unused views
         ^(id key, id object, BOOL *stop)
         {
             [contentViews removeObjectForKey:key];
             
             ReaderContentView *contentView = object;
             
             [contentView removeFromSuperview];
         }
         ];
        
		CGFloat viewWidthX1 = viewRect.size.width;
		CGFloat viewWidthX2 = (viewWidthX1 * 2.0f);
        
		CGPoint contentOffset = CGPointZero;
        
		if (maxPage >= PAGING_VIEWS)
		{
			if (page == minPage)
				contentOffset.x = viewWidthX2;
			else
				if (page != maxPage)
					contentOffset.x = viewWidthX1;
		}
		else
			if (page == (PAGING_VIEWS - 1))
				contentOffset.x = viewWidthX1;
        
		if (CGPointEqualToPoint(theScrollView.contentOffset, contentOffset) == false)
		{
			theScrollView.contentOffset = contentOffset; // Update content offset
		}
        
		if ([document.pageNumber integerValue] != page) // Only if different
		{
			document.pageNumber = [NSNumber numberWithInteger:page]; // Update it
		}
        
		[mainPagebar updatePageNumberDisplay]; // Update display
        
		currentPage = page; // Track current page number
	}
}

- (void)showDocument:(id)object
{

	[self updateScrollViewContentSize]; // Set content size
    NSString * currentFilename ;
    currentFilename = [document.fileName stringByReplacingOccurrencesOfString:@".pdf" withString:@""];
    [self checkAndCreatePList];
    if(!enlargeFont){

    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    NSString * documentName;

    documentName = [plistDict objectForKey:@"fileName"];
    if(documentName!=nil){
     currentFilename = [documentName stringByReplacingOccurrencesOfString:@".pdf" withString:@""];             
    } 
    }
    [plistDict setValue: [NSString stringWithFormat:@"%@",currentFilename]  forKey:@"fileName"];
    [plistDict writeToFile:pListPath atomically: YES];
    
        NSString * savedPage = [plistDict objectForKey:[NSString stringWithFormat:@"%@",document.fileName]];
    if(savedPage ==nil){
        savedPage=@"1";
    }
        [self showDocumentPage:[savedPage integerValue]]; // Show        
    
     

    
	document.lastOpen = [NSDate date]; // Update last opened date
    
	isVisible = YES; // iOS present modal WTF bodge
}

#pragma mark UIViewController methods

- (id)initWithReaderDocument:(ReaderDocument *)object
{

    
	id reader = nil; // ReaderViewController object
    
	if ((object != nil) && ([object isKindOfClass:[ReaderDocument class]]))
	{
		if ((self = [super initWithNibName:nil bundle:nil])) // Designated initializer
		{
			NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
            
			[notificationCenter addObserver:self selector:@selector(saveReaderDocument:) name:UIApplicationWillTerminateNotification object:nil];
            
			[notificationCenter addObserver:self selector:@selector(saveReaderDocument:) name:UIApplicationWillResignActiveNotification object:nil];
            
			document = [object retain]; // Retain the supplied ReaderDocument object for our use
            
			reader = self; // Return an initialized ReaderViewController object
		}
	}
    
	return reader;
}

 
- (void)viewDidLoad
{
    
	[super viewDidLoad];
    
	assert(delegate != nil); assert(document != nil);
    
	assert(self.splitViewController == nil); // Not supported (sorry)
    
	self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
	CGRect viewRect = self.view.bounds; // View controller's view bounds
    
	theScrollView = [[ReaderScrollView alloc] initWithFrame:viewRect]; // All
    
	theScrollView.scrollsToTop = NO;
	theScrollView.pagingEnabled = YES;
	theScrollView.delaysContentTouches = NO;
	theScrollView.showsVerticalScrollIndicator = NO;
	theScrollView.showsHorizontalScrollIndicator = NO;
	theScrollView.contentMode = UIViewContentModeRedraw;
	theScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	theScrollView.backgroundColor = [UIColor clearColor];
	theScrollView.userInteractionEnabled = YES;
	theScrollView.autoresizesSubviews = NO;
	theScrollView.delegate = self;
    
	[self.view addSubview:theScrollView];
    
	NSString *toolbarTitle = (self.title == nil) ? [document.fileName stringByDeletingPathExtension] : self.title;
    
	CGRect toolbarRect = viewRect;
	toolbarRect.size.height = TOOLBAR_HEIGHT;
    
	mainToolbar = [[ReaderMainToolbar alloc] initWithFrame:toolbarRect title:toolbarTitle]; // At top
    
	mainToolbar.delegate = self;
    
	[self.view addSubview:mainToolbar];
    
	CGRect pagebarRect = viewRect;
	pagebarRect.size.height = TOOLBAR_HEIGHT;
	pagebarRect.origin.y = (viewRect.size.height - TOOLBAR_HEIGHT);
    
	mainPagebar = [[ReaderMainPagebar alloc] initWithFrame:pagebarRect document:document]; // At bottom
    
	mainPagebar.delegate = self;
    
	[self.view addSubview:mainPagebar];
    
	UITapGestureRecognizer *singleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	singleTapOne.numberOfTouchesRequired = 1; singleTapOne.numberOfTapsRequired = 1; singleTapOne.delegate = self;
    
	UITapGestureRecognizer *doubleTapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
	doubleTapOne.numberOfTouchesRequired = 1; doubleTapOne.numberOfTapsRequired = 2; doubleTapOne.delegate = self;
    
	UITapGestureRecognizer *doubleTapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
	doubleTapTwo.numberOfTouchesRequired = 2; doubleTapTwo.numberOfTapsRequired = 2; doubleTapTwo.delegate = self;
    
	[singleTapOne requireGestureRecognizerToFail:doubleTapOne]; // Single tap requires double tap to fail
    
	[self.view addGestureRecognizer:singleTapOne]; [singleTapOne release];
	[self.view addGestureRecognizer:doubleTapOne]; [doubleTapOne release];
	[self.view addGestureRecognizer:doubleTapTwo]; [doubleTapTwo release];
    
	contentViews = [NSMutableDictionary new]; lastHideTime = [NSDate new];
}

- (void)viewWillAppear:(BOOL)animated
{

    
	[super viewWillAppear:animated];
    
	if (CGSizeEqualToSize(lastAppearSize, CGSizeZero) == false)
	{
		if (CGSizeEqualToSize(lastAppearSize, self.view.bounds.size) == false)
		{
			[self updateScrollViewContentViews]; // Update content views
		}
        
		lastAppearSize = CGSizeZero; // Reset view size tracking
	}
}

- (void)viewDidAppear:(BOOL)animated
{
 
	[super viewDidAppear:animated];
    
	if (CGSizeEqualToSize(theScrollView.contentSize, CGSizeZero)) // First time
	{
		[self performSelector:@selector(showDocument:) withObject:nil afterDelay:0.0];
	}
    
#if (READER_DISABLE_IDLE == TRUE) // Option
    
	[UIApplication sharedApplication].idleTimerDisabled = YES;
    
#endif // end of READER_DISABLE_IDLE Option
}

- (void)viewWillDisappear:(BOOL)animated
{

	[super viewWillDisappear:animated];
    
	lastAppearSize = self.view.bounds.size; // Track view size
    
#if (READER_DISABLE_IDLE == TRUE) // Option
    
	[UIApplication sharedApplication].idleTimerDisabled = NO;
    
#endif // end of READER_DISABLE_IDLE Option
}

- (void)viewDidDisappear:(BOOL)animated
{

	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{

	[mainToolbar release], mainToolbar = nil; [mainPagebar release], mainPagebar = nil;
    
	[theScrollView release], theScrollView = nil; [contentViews release], contentViews = nil;
    
	[lastHideTime release], lastHideTime = nil; lastAppearSize = CGSizeZero; currentPage = 0;
    
	[super viewDidUnload];
}

 

   
- (void)didReceiveMemoryWarning
{

	[super didReceiveMemoryWarning];
}

- (void)dealloc
{

    
	NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
	[notificationCenter removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
    
	[notificationCenter removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
	[mainToolbar release], mainToolbar = nil; [mainPagebar release], mainPagebar = nil;
    
	[theScrollView release], theScrollView = nil; [contentViews release], contentViews = nil;
    
	[lastHideTime release], lastHideTime = nil; [document release], document = nil;
    
	[super dealloc];
}

#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

	__block NSInteger page = 0;
    
	CGFloat contentOffsetX = scrollView.contentOffset.x;
    
	[contentViews enumerateKeysAndObjectsUsingBlock: // Enumerate content views
     ^(id key, id object, BOOL *stop)
     {
         ReaderContentView *contentView = object;
         
         if (contentView.frame.origin.x == contentOffsetX)
         {
             page = contentView.tag; *stop = YES;
         }
     }
     ];
    
	if (page != 0) [self showDocumentPage:page]; // Show the page
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

	[self showDocumentPage:theScrollView.tag]; // Show page
    
	theScrollView.tag = 0; // Clear page number tag
}

- (void)scrollViewTouchesBegan:(UIScrollView *)scrollView touches:(NSSet *)touches
{

	if ((mainToolbar.hidden == NO) || (mainPagebar.hidden == NO))
	{
		if (touches.count == 1) // Single touches only
		{
			UITouch *touch = [touches anyObject]; // Touch info
            
			CGPoint point = [touch locationInView:self.view]; // Location
            
			CGRect areaRect = CGRectInset(self.view.bounds, PAGING_AREA_WIDTH, TOOLBAR_HEIGHT);
            
			if (CGRectContainsPoint(areaRect, point) == false) return;
		}
        
		[mainToolbar hideToolbar]; [mainPagebar hidePagebar]; // Hide
        
		[lastHideTime release]; lastHideTime = [NSDate new];
	}
}

#pragma mark UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)recognizer shouldReceiveTouch:(UITouch *)touch
{
        if([self.view.subviews containsObject:bookMarkDone]){
            [bookMarkDone removeFromSuperview];
        }
	if ([touch.view isMemberOfClass:[ReaderScrollView class]]) return YES;
    
	return NO;
}

#pragma mark UIGestureRecognizer action methods

- (void)decrementPageNumber
{

    if([self.view.subviews containsObject:bookMarkDone]){
        [bookMarkDone removeFromSuperview];
    }
	if (theScrollView.tag == 0) // Scroll view did end
	{
		NSInteger page = [document.pageNumber integerValue];
		NSInteger maxPage = [document.pageCount integerValue];
		NSInteger minPage = 1; // Minimum
        
		if ((maxPage > minPage) && (page != minPage))
		{
			CGPoint contentOffset = theScrollView.contentOffset;
            
			contentOffset.x += theScrollView.bounds.size.width; // -= 1
            
			[theScrollView setContentOffset:contentOffset animated:YES];
            
			theScrollView.tag = (page - 1); // Decrement page number
		}
	}
}

- (void)incrementPageNumber
{

     if([self.view.subviews containsObject:bookMarkDone]){
        [bookMarkDone removeFromSuperview];
     }
	if (theScrollView.tag == 0) // Scroll view did end
	{
		NSInteger page = [document.pageNumber integerValue];
		NSInteger maxPage = [document.pageCount integerValue];
		NSInteger minPage = 1; // Minimum
        
		if ((maxPage > minPage) && (page != maxPage))
		{
			CGPoint contentOffset = theScrollView.contentOffset;
            
			contentOffset.x -= theScrollView.bounds.size.width; // += 1
            
			[theScrollView setContentOffset:contentOffset animated:YES];
            
			theScrollView.tag = (page + 1); // Increment page number
		}
	}
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{

	if (recognizer.state == UIGestureRecognizerStateRecognized)
	{
		CGRect viewRect = recognizer.view.bounds; // View bounds
        
		CGPoint point = [recognizer locationInView:recognizer.view];
        
		CGRect areaRect = CGRectInset(viewRect, PAGING_AREA_WIDTH, 0.0f);
        
		if (CGRectContainsPoint(areaRect, point)) // Single tap is inside the area
		{
			NSInteger page = [document.pageNumber integerValue]; // Current page #
            
			NSNumber *key = [NSNumber numberWithInteger:page]; // Page number key
            
			ReaderContentView *targetView = [contentViews objectForKey:key];
            
			id target = [targetView singleTap:recognizer]; // Process tap
            
			if (target != nil) // Handle the returned target object
			{
				if ([target isKindOfClass:[NSURL class]]) // Open a URL
				{
					[[UIApplication sharedApplication] openURL:target];
				}
				else // Not a URL, so check for other possible object type
				{
					if ([target isKindOfClass:[NSNumber class]]) // Goto page
					{
						NSInteger value = [target integerValue]; // Number
                        
						[self showDocumentPage:value]; // Show the page
					}
				}
			}
			else // Nothing active tapped in the target content view
			{
				if ([lastHideTime timeIntervalSinceNow] < -0.75) // Delay since hide
				{
					if ((mainToolbar.hidden == YES) || (mainPagebar.hidden == YES))
					{
						[mainToolbar showToolbar]; [mainPagebar showPagebar]; // Show
					}
				}
			}
            
			return;
		}
        
		CGRect nextPageRect = viewRect;
		nextPageRect.size.width = PAGING_AREA_WIDTH;
        
		if (CGRectContainsPoint(nextPageRect, point)) // page++ area
		{
            [self incrementPageNumber]; return;			 
		}
        
		CGRect prevPageRect = viewRect;
		prevPageRect.size.width = PAGING_AREA_WIDTH;
		prevPageRect.origin.x = (viewRect.size.width - PAGING_AREA_WIDTH);
        
		if (CGRectContainsPoint(prevPageRect, point)) // page-- area
		{
            [self decrementPageNumber]; return;			

		}
	}
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    
	if (recognizer.state == UIGestureRecognizerStateRecognized)
	{
		CGRect viewRect = recognizer.view.bounds; // View bounds
        
		CGPoint point = [recognizer locationInView:recognizer.view]; // Location
        
		CGRect zoomArea = CGRectInset(viewRect, PAGING_AREA_WIDTH, TOOLBAR_HEIGHT);
        
		if (CGRectContainsPoint(zoomArea, point)) // Double tap is in the zoom area
		{
			NSInteger page = [document.pageNumber integerValue]; // Current page #
            
			NSNumber *key = [NSNumber numberWithInteger:page]; // Page number key
            
			ReaderContentView *targetView = [contentViews objectForKey:key];
            if(zoom==0){
			 		[targetView zoomIncrement]; 
                zoom=1;
            }else if(zoom==1){
			 		[targetView zoomDecrement]; 
                zoom=0;
            }
        }
          
        
		CGRect nextPageRect = viewRect;
		nextPageRect.size.width = PAGING_AREA_WIDTH;
        
		if (CGRectContainsPoint(nextPageRect, point)) // page++ area
		{
            [self incrementPageNumber]; return; 
		}
        
		CGRect prevPageRect = viewRect;
		prevPageRect.size.width = PAGING_AREA_WIDTH;
		prevPageRect.origin.x = (viewRect.size.width - PAGING_AREA_WIDTH);
        
		if (CGRectContainsPoint(prevPageRect, point)) // page-- area
		{
            [self decrementPageNumber]; return;	
		}
	}
}

#pragma mark ReaderMainToolbarDelegate methods

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar doneButton:(UIBarButtonItem *)button
{
    
	[document saveReaderDocument]; // Save any ReaderDocument object changes
    
	if (printInteraction != nil) [printInteraction dismissAnimated:NO]; // Dismiss
    
	[delegate dismissReaderViewController:self]; // Dismiss view controller
}

/////////////////
- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar fontButton:(UIBarButtonItem *)button
{
    [self checkAndCreatePList];
    enlargeFont=TRUE;
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    NSString * fileName = @"";
    NSString * existFileName = [plistDict valueForKey:@"fileName"];
    if([existFileName rangeOfString:@"_2"].location == NSNotFound){
        fileName =  [[plistDict valueForKey:@"fileName"] stringByAppendingString:@"_2"];
    }else{
         fileName =  [[plistDict valueForKey:@"fileName"] stringByReplacingOccurrencesOfString:@"_2" withString:@""];
    }
    
    [myLibraryViewController dismissReaderViewController:self andShowDocumentWithName:fileName];
}

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar bookmarkButton:(UIBarButtonItem *)button
{
    [self checkAndCreatePList];
    plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    [plistDict setValue:document.pageNumber forKey:[NSString stringWithFormat:@"%@",document.fileName]];
    [plistDict writeToFile:pListPath atomically: YES];
    bookMarkDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [bookMarkDone addTarget:self 
                   action:@selector(backToLibrary)
         forControlEvents:UIControlEventTouchDown];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"bookmarkDone.png"];
    
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [bookMarkDone setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    
    bookMarkDone.frame = CGRectMake(self.view.bounds.size.width - 20.0, -100.0, 20.0, 100.0);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
 	bookMarkDone.frame = CGRectMake(self.view.bounds.size.width - 20.0, 0.0, 20.0, 100.0);
 	[UIView commitAnimations];
    [self.view addSubview:bookMarkDone];
}

-(void)checkAndCreatePList{
	BOOL success;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
 	pListPath = [ documentDir stringByAppendingPathComponent:@"sparkProperties.plist"];
  	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:pListPath];
	
	if(success) return;
	
	NSString *pListPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sparkProperties.plist"];
	
	[fileManager copyItemAtPath:pListPathFromApp toPath:pListPath error:nil];
	
	[fileManager release];
}
////////



- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar printButton:(UIBarButtonItem *)button
{
 #if (READER_ENABLE_PRINT == TRUE) // Option
    
	Class printInteractionController = NSClassFromString(@"UIPrintInteractionController");
    
	if ((printInteractionController != nil) && [printInteractionController isPrintingAvailable])
	{
		NSURL *fileURL = document.fileURL; // Document file URL
        
		printInteraction = [printInteractionController sharedPrintController];
        
		if ([printInteractionController canPrintURL:fileURL] == YES)
		{
			UIPrintInfo *printInfo = [NSClassFromString(@"UIPrintInfo") printInfo];
            
			printInfo.duplex = UIPrintInfoDuplexLongEdge;
			printInfo.outputType = UIPrintInfoOutputGeneral;
			printInfo.jobName = document.fileName;
            
			printInteraction.printInfo = printInfo;
			printInteraction.printingItem = fileURL;
			printInteraction.showsPageRange = YES;
            
			[printInteraction presentFromBarButtonItem:button animated:YES completionHandler:
             ^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
             {
#ifdef DEBUG
                 if ((completed == NO) && (error != nil)) NSLog(@"%s %@", __FUNCTION__, error);
#endif
             }
             ];
		}
	}
    
#endif // end of READER_ENABLE_PRINT Option
}

- (void)tappedInToolbar:(ReaderMainToolbar *)toolbar emailButton:(UIBarButtonItem *)button
{

    
#if (READER_ENABLE_MAIL == TRUE) // Option
    
	if ([MFMailComposeViewController canSendMail] == NO) return;
    
	if (printInteraction != nil) [printInteraction dismissAnimated:YES];
    
	unsigned long long fileSize = [document.fileSize unsignedLongLongValue];
    
	if (fileSize < (unsigned long long)15728640) // Check attachment size limit (15MB)
	{
		NSURL *fileURL = document.fileURL; NSString *fileName = document.fileName; // Document
        
		NSData *attachment = [NSData dataWithContentsOfURL:fileURL options:(NSDataReadingMapped|NSDataReadingUncached) error:nil];
        
		if (attachment != nil) // Ensure that we have valid document file attachment data
		{
			MFMailComposeViewController *mailComposer = [MFMailComposeViewController new];
            
			[mailComposer addAttachmentData:attachment mimeType:@"application/pdf" fileName:fileName];
            
			[mailComposer setSubject:fileName]; // Use the document file name for the subject
            
			mailComposer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
			mailComposer.modalPresentationStyle = UIModalPresentationFormSheet;
            
			mailComposer.mailComposeDelegate = self; // Set the delegate
            
			[self presentModalViewController:mailComposer animated:YES];
            
			[mailComposer release]; // Cleanup
		}
	}
	else // The document file is too large to email alert
	{
		UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"FileTooLargeTitle", @"text")
                                                           message:NSLocalizedString(@"FileTooLargeMessage", @"text") delegate:NULL
                                                 cancelButtonTitle:NSLocalizedString(@"OK", @"button") otherButtonTitles:nil];
        
		[theAlert show]; [theAlert release]; // Show and cleanup
	}
    
#endif // end of READER_ENABLE_MAIL Option
}

#pragma mark MFMailComposeViewControllerDelegate methods

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{

    
#ifdef DEBUG
	if ((result == MFMailComposeResultFailed) && (error != NULL)) NSLog(@"%@", error);
#endif
    
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark ReaderMainPagebarDelegate methods

- (void)pagebar:(ReaderMainPagebar *)pagebar gotoPage:(NSInteger)page
{

	[self showDocumentPage:page]; // Show the page
}

#pragma mark Notification methods

- (void)saveReaderDocument:(NSNotification *)notification
{

    
	[document saveReaderDocument]; // Save any ReaderDocument object changes
}

@end
