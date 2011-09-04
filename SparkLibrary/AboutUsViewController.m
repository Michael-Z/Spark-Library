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


@implementation AboutUsViewController

@synthesize aboutusTextView;



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
    aboutusTextView.text = NSLocalizedString(@"aboutUs", @"text");
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
    
    NSObject<EPGLTransitionViewDelegate> *transition;
    transition = [[[Transition alloc] init] autorelease];
    
    
    EPGLTransitionView *glview = [[[EPGLTransitionView alloc] 
                                   initWithView:self.navigationController.view
                                   delegate:transition] autorelease];
    
    
    [glview prepareTextureTo:viewController.view];
    // If you are using an "IN" animation for the "next" view set appropriate 
    // clear color (ie no alpha) 
    [glview setClearColorRed:0.0
                       green:0.0
                        blue:0.0
                       alpha:1.0];
    
    [glview startTransition];
    [self.navigationController popViewControllerAnimated:YES];
}




@end
