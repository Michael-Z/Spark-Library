//
//	ReaderDemoController.m
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

@implementation ReaderController

@synthesize fileName,backButton,tapButton;
#pragma mark Constants

#define SAMPLE_DOCUMENT @"Document.pdf"

#define DEMO_VIEW_CONTROLLER_PUSH FALSE

#pragma mark Properties

//@synthesize ;

#pragma mark UIViewController methods

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		// Custom initialization
	}

	return self;
}
*/

/*
- (void)loadView
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	// Implement loadView to create a view hierarchy programmatically, without using a nib.
}
*/

- (void)viewDidLoad
{
#ifdef DEBUGX
	NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(self.view.bounds));
#endif

	[super viewDidLoad];

	self.view.backgroundColor = [UIColor clearColor]; // Transparent

	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

	NSString *name = [infoDictionary objectForKey:@"CFBundleName"];

	NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];

	self.title = [NSString stringWithFormat:@"%@ v%@", name, version];

	CGSize viewSize = self.view.bounds.size;

	CGRect labelRect = CGRectMake(0.0f, 0.0f, 500.0f, 52.0f);

	//UILabel *tapLabel = [[UILabel alloc] initWithFrame:labelRect];
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton addTarget:self 
                   action:@selector(backToLibrary)
         forControlEvents:UIControlEventTouchDown];
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"page.png"];
    
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [backButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(20.0, 0.0, 73.0, 29.0);
    
    
    [self.view addSubview:backButton];
        
    
    tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
     
    UIImage *buttonTapImageNormal = [UIImage imageNamed:@"startRead.png"];
    
    UIImage *strechableButtonTapImageNormal = [buttonTapImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    
    [tapButton setBackgroundImage:strechableButtonTapImageNormal forState:UIControlStateNormal];
    
    tapButton.frame =CGRectMake(0.0f, 0.0f, 400.0f, 75.0f);
    tapButton.center = CGPointMake(viewSize.width/2.0f , viewSize.height /2.0f);
    
/*	tapLabel.text = @"إضغط للبدء في القراءة";
    tapLabel.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"startRead.png"]];
	tapLabel.textColor = [UIColor redColor];
	tapLabel.textAlignment = UITextAlignmentCenter;
	tapLabel.backgroundColor = [UIColor clearColor];
	tapLabel.font = [UIFont systemFontOfSize:44.0f];
	tapLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	tapLabel.autoresizingMask |= UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
	tapLabel.center = CGPointMake(viewSize.width / 2.0f, viewSize.height / 2.0f);
*/
    [self.view addSubview:tapButton]; [tapButton release];
 
	UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	//singleTap.numberOfTouchesRequired = 1; singleTap.numberOfTapsRequired = 1; //singleTap.delegate = self;
	[self.view addGestureRecognizer:singleTap]; [singleTap release];
}

- (void)viewWillAppear:(BOOL)animated
{
#ifdef DEBUGX
	NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(self.view.bounds));
#endif

	[super viewWillAppear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:NO animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidAppear:(BOOL)animated
{
#ifdef DEBUGX
	NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(self.view.bounds));
#endif

	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
#ifdef DEBUGX
	NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(self.view.bounds));
#endif

	[super viewWillDisappear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:YES animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidDisappear:(BOOL)animated
{
#ifdef DEBUGX
	NSLog(@"%s %@", __FUNCTION__, NSStringFromCGRect(self.view.bounds));
#endif

	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
#ifdef DEBUGX
	NSLog(@"%s (%d)", __FUNCTION__, interfaceOrientation);
#endif

	return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
#ifdef DEBUGX
	NSLog(@"%s %@ (%d)", __FUNCTION__, NSStringFromCGRect(self.view.bounds), toInterfaceOrientation);
#endif
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{
#ifdef DEBUGX
	NSLog(@"%s %@ (%d)", __FUNCTION__, NSStringFromCGRect(self.view.bounds), interfaceOrientation);
#endif
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
#ifdef DEBUGX
	NSLog(@"%s %@ (%d to %d)", __FUNCTION__, NSStringFromCGRect(self.view.bounds), fromInterfaceOrientation, self.interfaceOrientation);
#endif

	//if (fromInterfaceOrientation == self.interfaceOrientation) return;
}

- (void)didReceiveMemoryWarning
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[super didReceiveMemoryWarning];
}

- (void)dealloc
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	[super dealloc];
}

#pragma mark UIGestureRecognizer methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

	ReaderDocument *document = [ReaderDocument unarchiveFromFileName:SAMPLE_DOCUMENT];

	if (document == nil) // Create a brand new ReaderDocument object the first time we run
	{
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectoryPath = [searchPaths objectAtIndex:0]; 
        NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[[NSString stringWithFormat:@"%@",fileName] stringByAppendingPathExtension:@"pdf"]];

        
        NSLog(@"%@",path);
        [self checkAndCreatePList];
        NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
        
        [plistDict setValue: [NSString stringWithFormat:@"%@",fileName]  forKey:@"fileName"];
        [plistDict writeToFile:pListPath atomically: YES];
        
        
        
//		NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];

		document = [[[ReaderDocument alloc] initWithFilePath:path password:nil] autorelease];
	}

	if (document != nil) // Must have a valid ReaderDocument object in order to proceed
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];

		readerViewController.delegate = self; // Set the ReaderViewController delegate to self

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

		[self.navigationController pushViewController:readerViewController animated:YES];

#else // present in a modal view controller

		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;

		[self presentModalViewController:readerViewController animated:YES];

#endif // DEMO_VIEW_CONTROLLER_PUSH

		[readerViewController release]; // Release the ReaderViewController
	}
}

#pragma mark ReaderViewControllerDelegate methods

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController popViewControllerAnimated:YES];

#else // dismiss the modal view controller

	[self dismissModalViewControllerAnimated:YES];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}


-(void) backToLibrary{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];    
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




















- (void)reloadThePDF:(NSString *)theFileName
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    
	ReaderDocument *document = [ReaderDocument unarchiveFromFileName:SAMPLE_DOCUMENT];
    
	if (document == nil) // Create a brand new ReaderDocument object the first time we run
	{
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectoryPath = [searchPaths objectAtIndex:0]; 
        NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[[NSString stringWithFormat:@"%@",theFileName] stringByAppendingPathExtension:@"pdf"]];
        
        
        
        [self checkAndCreatePList];
        NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
        
        [plistDict setValue: [NSString stringWithFormat:@"%@",theFileName]  forKey:@"fileName"];
        [plistDict writeToFile:pListPath atomically: YES];
        
        
        
        //		NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
        
		document = [[[ReaderDocument alloc] initWithFilePath:path password:nil] autorelease];
	}
    
	if (document != nil) // Must have a valid ReaderDocument object in order to proceed
	{
		ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
        
		readerViewController.delegate = self; // Set the ReaderViewController delegate to self
        
#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)
        
		[self.navigationController pushViewController:readerViewController animated:YES];
        
#else // present in a modal view controller
        
		readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
		readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        
		[self presentModalViewController:readerViewController animated:YES];
        
#endif // DEMO_VIEW_CONTROLLER_PUSH
        
		[readerViewController release]; // Release the ReaderViewController
	}
}
@end
