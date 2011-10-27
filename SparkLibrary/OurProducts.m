//
//  OurProducts.m
//  SparkLibrary
//
//  Created by Mohamed Hegab on 9/6/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "OurProducts.h"

@implementation OurProducts


@synthesize goTo;
@synthesize chapters,links;


-(NSInteger)tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger)section{
	return [self.chapters count];
	
}
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath
{
    static NSString *SimpleTableIdentifier =@"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
	if(cell== nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:SimpleTableIdentifier]autorelease];
	}
	NSUInteger row = [indexPath row];
	
	cell.textLabel.text = [chapters objectAtIndex:row];
	cell.textLabel.textAlignment =UITextAlignmentRight;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.opaque = NO;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *viewController;
    NSString *urlString;
    NSURL *url;
    
    switch (indexPath.row) {
            
            
        case 0:
            urlString =[self.links objectAtIndex:indexPath.row];
            url= [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 1:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 2:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 3:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 4:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 5:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 6:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 7:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 8:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 9:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 10:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 11:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 12:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 13:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 14:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 15:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 16:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 17:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 18:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 19:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 20:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 21:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 22:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 23:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 24:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 25:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 26:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 27:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 28:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 29:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 30:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 31:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 32:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 33:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 34:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 35:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 36:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 37:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 38:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 39:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 40:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 41:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 42:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 43:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 44:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 45:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 46:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 47:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 48:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 49:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 50:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 51:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 52:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 53:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 54:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 55:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 56:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 57:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 58:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 59:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
        case 60:
            urlString =[self.links objectAtIndex:indexPath.row];
            url = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:url];
            break;
    }
	[self.navigationController pushViewController:viewController animated:YES];
}


-(void)checkAndCreatePList{
	BOOL success;
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentDir = [documentPaths objectAtIndex:0];
 	pListPath = [ documentDir stringByAppendingPathComponent:@"productlist.plist"];
  	NSFileManager *fileManager = [NSFileManager defaultManager];
	success = [fileManager fileExistsAtPath:pListPath];
 	
	if(success) {
		return;
	}
	
	
	NSString *pListPathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"productlist.plist"];
	
	[fileManager copyItemAtPath:pListPathFromApp toPath:pListPath error:nil];
	
	[fileManager release];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    [self checkAndCreatePList];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:pListPath];
    
    NSArray *_array;
    NSArray *_links;
    _array = [plistDict objectForKey:@"app"];
    _links = [plistDict objectForKey:@"link"];
	self.chapters=_array;
    self.links = _links;
    [_array release];
    [_links release];

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
     
}

-(IBAction)backToParent:(id)sender{
    [[self parentViewController] dismissModalViewControllerAnimated:YES];    
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
@end
