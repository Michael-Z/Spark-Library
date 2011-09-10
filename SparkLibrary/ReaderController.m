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

 

- (void)viewDidLoad
{
 
	[super viewDidLoad];

	self.view.backgroundColor = [UIColor clearColor]; // Transparent

	NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];

	NSString *name = [infoDictionary objectForKey:@"CFBundleName"];

	NSString *version = [infoDictionary objectForKey:@"CFBundleVersion"];

	self.title = [NSString stringWithFormat:@"%@ v%@", name, version];

	CGSize viewSize = self.view.bounds.size;

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
 
	[super viewWillAppear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:NO animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidAppear:(BOOL)animated
{
 
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
 	[super viewWillDisappear:animated];

#if (DEMO_VIEW_CONTROLLER_PUSH == TRUE)

	[self.navigationController setNavigationBarHidden:YES animated:animated];

#endif // DEMO_VIEW_CONTROLLER_PUSH
}

- (void)viewDidDisappear:(BOOL)animated
{

	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
 	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 	return NO;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
 }

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration
{

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

	[super didReceiveMemoryWarning];
}

- (void)dealloc
{

	[super dealloc];
}

#pragma mark UIGestureRecognizer methods

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{

	ReaderDocument *document = [ReaderDocument unarchiveFromFileName:SAMPLE_DOCUMENT];

	if (document == nil) // Create a brand new ReaderDocument object the first time we run
	{
        NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectoryPath = [searchPaths objectAtIndex:0]; 
        NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:[[NSString stringWithFormat:@"%@",fileName] stringByAppendingPathExtension:@"pdf"]];

        
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
