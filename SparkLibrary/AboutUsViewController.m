//
//  AboutUsViewController.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/4/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Transition.h"
#import "RootViewController.h"
#import "TheDarkDimension.h"
#import "OurProducts.h"
@implementation AboutUsViewController

@synthesize aboutusWebView;



-(void)viewDidAppear:(BOOL)animated{
    
    
    UIButton * leftButtonItem = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
	leftButtonItem.frame = CGRectMake(0.0, 0.0, 52.5, 30.0);
	leftButtonItem.backgroundColor = [UIColor clearColor];
    [leftButtonItem setImage: [UIImage imageNamed:@"backBarButton.png"] forState:UIControlStateNormal];
	[leftButtonItem addTarget:self action:@selector(goBackToRootViewController) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:leftButtonItem];
	self.navigationItem.leftBarButtonItem = leftButton;
	[leftButtonItem release];
	[leftButton release];
    
   
    [super viewDidAppear:animated];    

}
-(void)viewWillAppear:(BOOL)animated{
    [self.aboutusWebView setBackgroundColor:[UIColor clearColor]];
    [self.aboutusWebView setOpaque:NO];
    NSString* html = [NSString stringWithFormat:@"<html><body><p \"style=\"font-size:20px;text-align:right; color:black; direction:rtl;\">%@</p></body></html>",NSLocalizedString(@"aboutUs", @"text")];
    [self.aboutusWebView loadHTMLString:html baseURL:nil];
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


-(void) goBackToRootViewController {
    UIViewController *viewController;
    
    viewController = [[[RootViewController alloc] init] autorelease] ;
  
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
	switch (result) {
		case MessageComposeResultCancelled:
		 
			break;
		case MessageComposeResultFailed:
		 
 			break;
		case MessageComposeResultSent:
             
			break;
		default:
			break;
	}
	
	[self dismissModalViewControllerAnimated:YES];
}



-(IBAction)sendMail:(id)sender{
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:@"مقترحات لمكتبة سبارك"];
    NSMutableArray * emails = [[NSMutableArray alloc] init];
    [emails addObject:@"admin@spark-books.com,"];
    [controller setToRecipients:emails];
	[self presentModalViewController:controller animated:YES];
	[controller release];
    [emails release];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {

		NSLog(@"It's away!");
		
	}
	[self dismissModalViewControllerAnimated:YES];
}
 -(IBAction)darkDimensionWebSiteLunching:(id)sender{
    
     
     UIViewController *viewController;
    
    viewController = [[TheDarkDimension alloc] init] ;
    [self.navigationController presentModalViewController:viewController animated:YES];
}


-(IBAction)ourProduct:(id)sender{
    UIViewController *viewController;
    
    viewController = [[OurProducts alloc] init] ;
    [self.navigationController presentModalViewController:viewController animated:YES];
}
@end
