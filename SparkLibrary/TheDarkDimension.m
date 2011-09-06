//
//  TheDarkDimension.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/5/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "TheDarkDimension.h"

@implementation TheDarkDimension

@synthesize webView;

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

-(void)viewDidAppear:(BOOL)animated{
     [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.thedarkdimension.com"]]];
}
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

-(IBAction)backToParent:(id)sender{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];    
}


@end