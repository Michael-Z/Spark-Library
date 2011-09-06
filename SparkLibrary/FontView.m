//
//  FontView.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 8/29/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "FontView.h"
#import "ReaderController.h"
#import "ReaderMainToolbar.h"
#import "ReaderViewController.h"

@implementation FontView


@synthesize myLibraryViewController, readerController;


-(IBAction)getPDF1:(id)sender
{
    [self checkAndCreatePList];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    NSString * fileName =  [[plistDict valueForKey:@"fileName"] stringByAppendingString:@"_2"];
    
    NSLog(@"%@",fileName);
    
    [myLibraryViewController dismissReaderViewController:readerController andShowDocumentWithName:@"dark.matter"];

}

-(IBAction)getPDF2:(id)sender
{
    
    [self checkAndCreatePList];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
   NSString * fileName =  [[plistDict valueForKey:@"fileName"] stringByAppendingString:@"_2"];
 
    NSLog(@"%@",fileName);
    
    [myLibraryViewController dismissReaderViewController:readerController andShowDocumentWithName:@"dark.matter_2"];
}

 


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

@end
